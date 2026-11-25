package edu.asu.cse412.movieagent.tools;

import edu.asu.cse412.movieagent.agent.Json;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * The predefined tools from the proposal. The LLM never writes SQL - it only picks a tool and
 * fills in arguments; every query here is a parameterized PreparedStatement.
 * SQL is written to run on both PostgreSQL and H2 (PostgreSQL mode).
 */
public class MovieTools {
    private static final Logger log = LoggerFactory.getLogger(MovieTools.class);
    private final DataSource ds;

    /** Last SQL statement executed (shown in the UI trace). */
    private final ThreadLocal<List<String>> sqlLog = ThreadLocal.withInitial(ArrayList::new);

    public MovieTools(DataSource ds) {
        this.ds = ds;
    }

    // ------------------------------------------------------------------ tool definitions (sent to the LLM)
    public static final List<Map<String, Object>> SCHEMAS = List.of(
        tool("search_movies",
            "Find movies matching filters. All filters are optional; combine them as needed. "
            + "Use this to list/find movies by title, genre, director, actor or release year.",
            props(
                "title", p("string", "Part of the movie title"),
                "genre", p("string", "Genre name, e.g. Horror, Comedy, Sci-Fi"),
                "director", p("string", "Director name (partial ok)"),
                "actor", p("string", "Actor name (partial ok)"),
                "year_from", p("integer", "Earliest release year (inclusive)"),
                "year_to", p("integer", "Latest release year (inclusive)"))),
        tool("get_movie_details",
            "Get full details for ONE movie: release date, director, genres, actors, average rating.",
            props("title", p("string", "The movie title")), "title"),
        tool("get_movie_ratings",
            "Get rating statistics for ONE movie: average, count, min, max and each user's score.",
            props("title", p("string", "The movie title")), "title"),
        tool("recommend_movies",
            "Recommend well-rated movies. Use similar_to to find movies that share genres with a movie "
            + "the user liked. All filters optional.",
            props(
                "genre", p("string", "Genre name"),
                "director", p("string", "Director name"),
                "actor", p("string", "Actor name"),
                "year_from", p("integer", "Earliest release year"),
                "year_to", p("integer", "Latest release year"),
                "min_rating", p("number", "Minimum average rating (1-10)"),
                "similar_to", p("string", "Title of a movie the user liked"),
                "limit", p("integer", "How many to return (default 5)")))
    );

    // ------------------------------------------------------------------ dispatcher
    /** Runs a tool; returns its JSON result. SQL executed is available via {@link #drainSqlLog()}. */
    public String call(String name, Map<String, Object> a) throws SQLException {
        log.info("TOOL  {} {}", name, a);
        Object result = switch (name) {
            case "search_movies" -> searchMovies(str(a, "title"), str(a, "genre"), str(a, "director"),
                    str(a, "actor"), integer(a, "year_from"), integer(a, "year_to"));
            case "get_movie_details" -> getMovieDetails(str(a, "title"));
            case "get_movie_ratings" -> getMovieRatings(str(a, "title"));
            case "recommend_movies" -> recommendMovies(str(a, "genre"), str(a, "director"), str(a, "actor"),
                    integer(a, "year_from"), integer(a, "year_to"), number(a, "min_rating"),
                    str(a, "similar_to"), integer(a, "limit"));
            default -> Map.of("error", "Unknown tool: " + name);
        };
        String json = Json.stringify(result);
        log.debug("TOOL RESULT {} -> {}", name, json.length() > 500 ? json.substring(0, 500) + "..." : json);
        return json;
    }

    public List<String> drainSqlLog() {
        List<String> out = new ArrayList<>(sqlLog.get());
        sqlLog.get().clear();
        return out;
    }

    public List<String> genres() throws SQLException {
        List<String> g = new ArrayList<>();
        for (Map<String, Object> r : query("SELECT CAST(name AS VARCHAR) AS name FROM genre ORDER BY 1", Map.of())) g.add((String) r.get("name"));
        sqlLog.get().clear();
        return g;
    }

    // ------------------------------------------------------------------ shared SQL fragments
    // Schema (Group 24 DB): movie(movie_id, title, release_date, director), genre(genre_id, name),
    // movie_genre(movie_id, genre_id), person(person_id, person_name, dob), role(role_id, movie_id, person_id, role_type),
    // rating(rating_id, rating_value, movie_id, user_id), "user"(user_id, username, email, password).
    // Text columns use PostgreSQL's "name" type, so they are CAST to VARCHAR before string functions.
    private static final String YEAR = "CAST(EXTRACT(YEAR FROM m.release_date) AS INTEGER)";
    private static final String GENRES = "(SELECT STRING_AGG(CAST(g.name AS VARCHAR), ', ' ORDER BY CAST(g.name AS VARCHAR)) "
            + "FROM movie_genre mg JOIN genre g ON g.genre_id = mg.genre_id WHERE mg.movie_id = m.movie_id)";
    private static final String DIRECTOR = "CAST(m.director AS VARCHAR)";
    private static final String AVG_RATING = "(SELECT ROUND(AVG(CAST(ra.rating_value AS DECIMAL(6,2))), 1) "
            + "FROM rating ra WHERE ra.movie_id = m.movie_id)";
    private static final String NUM_RATINGS = "(SELECT COUNT(*) FROM rating ra WHERE ra.movie_id = m.movie_id)";
    private static final String FILTERS = """
              AND (CAST(:genre AS VARCHAR) IS NULL OR EXISTS (SELECT 1 FROM movie_genre mg
                   JOIN genre g ON g.genre_id = mg.genre_id
                   WHERE mg.movie_id = m.movie_id AND CAST(g.name AS VARCHAR) ILIKE CAST(:genre AS VARCHAR)))
              AND (CAST(:director AS VARCHAR) IS NULL OR CAST(m.director AS VARCHAR) ILIKE '%' || CAST(:director AS VARCHAR) || '%')
              AND (CAST(:actor AS VARCHAR) IS NULL OR EXISTS (SELECT 1 FROM role r
                   JOIN person p ON p.person_id = r.person_id WHERE r.movie_id = m.movie_id
                   AND CAST(r.role_type AS VARCHAR) = 'Actor'
                   AND CAST(p.person_name AS VARCHAR) ILIKE '%' || CAST(:actor AS VARCHAR) || '%'))
              AND (CAST(:year_from AS INTEGER) IS NULL OR EXTRACT(YEAR FROM m.release_date) >= CAST(:year_from AS INTEGER))
              AND (CAST(:year_to AS INTEGER) IS NULL OR EXTRACT(YEAR FROM m.release_date) <= CAST(:year_to AS INTEGER))
            """;

    // ------------------------------------------------------------------ tools
    public List<Map<String, Object>> searchMovies(String title, String genre, String director, String actor,
                                                  Integer yearFrom, Integer yearTo) throws SQLException {
        String sql = """
            SELECT CAST(m.title AS VARCHAR) AS title, %s AS release_year, %s AS genres, %s AS director,
                   %s AS avg_rating, COUNT(*) OVER () AS total_matches
            FROM movie m
            WHERE (CAST(:title AS VARCHAR) IS NULL OR CAST(m.title AS VARCHAR) ILIKE '%%' || CAST(:title AS VARCHAR) || '%%')
            %s
            ORDER BY avg_rating DESC NULLS LAST, title
            LIMIT 15
            """.formatted(YEAR, GENRES, DIRECTOR, AVG_RATING, FILTERS);
        return query(sql, params("title", title, "genre", genre, "director", director, "actor", actor,
                "year_from", yearFrom, "year_to", yearTo));
    }

    public Object getMovieDetails(String title) throws SQLException {
        Integer id = findmovie_id(title);
        if (id == null) return Map.of("error", "No movie found matching '" + title + "'");
        String sql = """
            SELECT CAST(m.title AS VARCHAR) AS title, m.release_date, %s AS director, %s AS genres,
                   (SELECT STRING_AGG(CAST(p.person_name AS VARCHAR), ', ' ORDER BY CAST(p.person_name AS VARCHAR))
                      FROM role r JOIN person p ON p.person_id = r.person_id
                     WHERE r.movie_id = m.movie_id AND CAST(r.role_type AS VARCHAR) = 'Actor') AS actors,
                   %s AS avg_rating, %s AS num_ratings
            FROM movie m WHERE m.movie_id = :id
            """.formatted(DIRECTOR, GENRES, AVG_RATING, NUM_RATINGS);
        return query(sql, params("id", id)).get(0);
    }

    public Object getMovieRatings(String title) throws SQLException {
        Integer id = findmovie_id(title);
        if (id == null) return Map.of("error", "No movie found matching '" + title + "'");
        Map<String, Object> out = new LinkedHashMap<>(query("""
            SELECT CAST(m.title AS VARCHAR) AS title,
                   ROUND(AVG(CAST(r.rating_value AS DECIMAL(6,2))), 1) AS avg_rating,
                   COUNT(r.rating_value) AS num_ratings, MIN(r.rating_value) AS min_rating, MAX(r.rating_value) AS max_rating
            FROM movie m LEFT JOIN rating r ON r.movie_id = m.movie_id
            WHERE m.movie_id = :id GROUP BY m.title
            """, params("id", id)).get(0));
        out.put("ratings", query("""
            SELECT CAST(u.username AS VARCHAR) AS username, r.rating_value AS score
            FROM rating r JOIN "user" u ON u.user_id = r.user_id
            WHERE r.movie_id = :id ORDER BY r.rating_value DESC, username
            """, params("id", id)));
        return out;
    }

    public List<Map<String, Object>> recommendMovies(String genre, String director, String actor, Integer yearFrom,
                                                     Integer yearTo, Double minRating, String similarTo,
                                                     Integer limit) throws SQLException {
        Integer seedId = similarTo == null ? null : findmovie_id(similarTo);
        String sql = """
            SELECT CAST(m.title AS VARCHAR) AS title, %s AS release_year, %s AS genres, %s AS director,
                   %s AS avg_rating, %s AS num_ratings,
                   (SELECT COUNT(*) FROM movie_genre a JOIN movie_genre b ON a.genre_id = b.genre_id
                     WHERE a.movie_id = m.movie_id AND b.movie_id = CAST(:seed AS INTEGER)) AS shared_genres
            FROM movie m
            WHERE (CAST(:min_rating AS DOUBLE PRECISION) IS NULL OR %s >= CAST(:min_rating AS DOUBLE PRECISION))
              AND (CAST(:seed AS INTEGER) IS NULL OR m.movie_id <> CAST(:seed AS INTEGER))
            %s
            ORDER BY shared_genres DESC, avg_rating DESC NULLS LAST, num_ratings DESC, title
            LIMIT :lim
            """.formatted(YEAR, GENRES, DIRECTOR, AVG_RATING, NUM_RATINGS, AVG_RATING, FILTERS);
        List<Map<String, Object>> rows = query(sql, params("seed", seedId, "min_rating", minRating,
                "genre", genre, "director", director, "actor", actor, "year_from", yearFrom, "year_to", yearTo,
                "lim", limit == null || limit < 1 ? 5 : Math.min(limit, 20)));
        if (seedId == null) rows.forEach(r -> r.remove("shared_genres"));
        return rows;
    }

    /** Fuzzy title lookup: exact match first, then "title contains text", then "text contains title". */
    private Integer findmovie_id(String title) throws SQLException {
        if (title == null) return null;
        List<Map<String, Object>> r = query("""
            SELECT m.movie_id FROM movie m
            WHERE CAST(m.title AS VARCHAR) ILIKE '%' || CAST(:t AS VARCHAR) || '%'
               OR CAST(:t AS VARCHAR) ILIKE '%' || CAST(m.title AS VARCHAR) || '%'
            ORDER BY CASE WHEN LOWER(CAST(m.title AS VARCHAR)) = LOWER(CAST(:t AS VARCHAR)) THEN 0
                          WHEN CAST(m.title AS VARCHAR) ILIKE '%' || CAST(:t AS VARCHAR) || '%' THEN 1 ELSE 2 END,
                     LENGTH(CAST(m.title AS VARCHAR))
            LIMIT 1
            """, params("t", title));
        return r.isEmpty() ? null : ((Number) r.get(0).get("movie_id")).intValue();
    }

    // ------------------------------------------------------------------ JDBC helpers
    private static final Pattern NAMED = Pattern.compile("(?<![:\\w]):([a-z_]+)");

    /** Runs SQL with :named parameters (converted to ? for a PreparedStatement). */
    private List<Map<String, Object>> query(String sql, Map<String, Object> params) throws SQLException {
        List<Object> values = new ArrayList<>();
        Matcher m = NAMED.matcher(sql);
        StringBuilder jdbcSql = new StringBuilder();
        while (m.find()) {
            m.appendReplacement(jdbcSql, "?");
            values.add(params.get(m.group(1)));
        }
        m.appendTail(jdbcSql);

        Map<String, Object> shown = new LinkedHashMap<>();
        params.forEach((k, v) -> { if (v != null) shown.put(k, v); });
        sqlLog.get().add(sql.strip() + (shown.isEmpty() ? "" : "\n-- params: " + shown));
        log.debug("SQL\n{}\n-- params: {}", sql.strip(), shown);

        try (Connection c = ds.getConnection(); PreparedStatement ps = c.prepareStatement(jdbcSql.toString())) {
            for (int i = 0; i < values.size(); i++) ps.setObject(i + 1, values.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                ResultSetMetaData md = rs.getMetaData();
                List<Map<String, Object>> rows = new ArrayList<>();
                while (rs.next()) {
                    Map<String, Object> row = new LinkedHashMap<>();
                    for (int col = 1; col <= md.getColumnCount(); col++)
                        row.put(md.getColumnLabel(col).toLowerCase(), rs.getObject(col));
                    rows.add(row);
                }
                log.debug("SQL -> {} row(s)", rows.size());
                return rows;
            }
        } catch (SQLException e) {
            log.error("SQL FAILED: {} (SQLState {})\n{}\n-- params: {}", e.getMessage(), e.getSQLState(), sql.strip(), shown);
            throw e;
        }
    }

    private static Map<String, Object> params(Object... kv) {
        Map<String, Object> m = new HashMap<>();
        for (int i = 0; i < kv.length; i += 2) m.put((String) kv[i], kv[i + 1]);
        return m;
    }

    // ------------------------------------------------------------------ argument coercion (LLMs are sloppy)
    private static boolean empty(Object v) {
        if (v == null) return true;
        String s = v.toString().trim().toLowerCase();
        return s.isEmpty() || s.equals("null") || s.equals("none") || s.equals("any") || s.equals("all");
    }

    private static String str(Map<String, Object> a, String k) {
        Object v = a.get(k);
        return empty(v) ? null : v.toString().trim();
    }

    private static Integer integer(Map<String, Object> a, String k) {
        Object v = a.get(k);
        if (empty(v)) return null;
        if (v instanceof Number n) return n.intValue();
        try { return (int) Double.parseDouble(v.toString().trim()); } catch (NumberFormatException e) { return null; }
    }

    private static Double number(Map<String, Object> a, String k) {
        Object v = a.get(k);
        if (empty(v)) return null;
        if (v instanceof Number n) return n.doubleValue();
        try { return Double.parseDouble(v.toString().trim()); } catch (NumberFormatException e) { return null; }
    }

    // ------------------------------------------------------------------ JSON-schema builders
    private static Map<String, Object> tool(String name, String desc, Map<String, Object> properties, String... required) {
        Map<String, Object> params = new LinkedHashMap<>();
        params.put("type", "object");
        params.put("properties", properties);
        params.put("required", List.of(required));
        Map<String, Object> fn = new LinkedHashMap<>();
        fn.put("name", name);
        fn.put("description", desc);
        fn.put("parameters", params);
        Map<String, Object> t = new LinkedHashMap<>();
        t.put("type", "function");
        t.put("function", fn);
        return t;
    }

    private static Map<String, Object> props(Object... kv) {
        Map<String, Object> m = new LinkedHashMap<>();
        for (int i = 0; i < kv.length; i += 2) m.put((String) kv[i], kv[i + 1]);
        return m;
    }

    private static Map<String, Object> p(String type, String desc) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("type", type);
        m.put("description", desc);
        return m;
    }
}
