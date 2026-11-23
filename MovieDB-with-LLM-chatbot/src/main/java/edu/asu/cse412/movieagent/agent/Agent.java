package edu.asu.cse412.movieagent.agent;

import edu.asu.cse412.movieagent.tools.MovieTools;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * The agent = a loop (one instance per browser session, so it remembers the conversation):
 *   1. send conversation + tool definitions to the LLM
 *   2. if the LLM asks for tool calls -> run them against the database, append results, go to 1
 *   3. otherwise the LLM's text is the final natural-language answer
 */
public class Agent {
    private static final Logger log = LoggerFactory.getLogger(Agent.class);
    private static final int MAX_STEPS = 6;

    /** One tool call made while answering - returned to the UI so the demo shows what happened. */
    public record ToolStep(String tool, Map<String, Object> args, List<String> sql, String result, long millis) {}

    public record Reply(String answer, List<ToolStep> steps, long millis) {}

    private final LlmClient llm;
    private final MovieTools tools;
    private final List<Map<String, Object>> history = new ArrayList<>();

    public Agent(LlmClient llm, MovieTools tools, String systemPrompt) {
        this.llm = llm;
        this.tools = tools;
        history.add(msg("system", systemPrompt));
    }

    public synchronized void reset() {
        Map<String, Object> system = history.get(0);
        history.clear();
        history.add(system);
    }

    @SuppressWarnings("unchecked")
    public synchronized Reply ask(String userText) throws Exception {
        long start = System.currentTimeMillis();
        List<ToolStep> steps = new ArrayList<>();
        history.add(msg("user", userText));
        log.info("USER  {}", userText);

        for (int step = 0; step < MAX_STEPS; step++) {
            Map<String, Object> reply = llm.chat(history, MovieTools.SCHEMAS);
            List<Object> calls = (List<Object>) reply.get("tool_calls");
            log.debug("LLM step {} -> {}", step + 1, Json.stringify(reply));

            Map<String, Object> assistant = new LinkedHashMap<>();
            assistant.put("role", "assistant");
            assistant.put("content", reply.get("content"));

            if (calls == null || calls.isEmpty()) {             // final answer
                history.add(assistant);
                trimHistory();
                Object content = reply.get("content");
                log.info("ANSWER ({} ms, {} tool call(s)): {}", System.currentTimeMillis() - start, steps.size(), content);
                return new Reply(content == null ? "" : content.toString().trim(), steps,
                        System.currentTimeMillis() - start);
            }

            assistant.put("tool_calls", calls);                  // LLM wants data
            history.add(assistant);
            for (Object o : calls) {
                Map<String, Object> call = (Map<String, Object>) o;
                Map<String, Object> fn = (Map<String, Object>) call.get("function");
                String name = String.valueOf(fn.get("name"));
                Map<String, Object> args = parseArgs(fn.get("arguments"));

                long t0 = System.currentTimeMillis();
                String result;
                try {
                    result = tools.call(name, args);
                } catch (Exception e) {
                    log.error("Tool {} failed with args {}", name, args, e);
                    Map<String, Object> err = new LinkedHashMap<>();
                    err.put("error", String.valueOf(e.getMessage()));
                    result = Json.stringify(err);
                }
                steps.add(new ToolStep(name, args, tools.drainSqlLog(), result, System.currentTimeMillis() - t0));

                Map<String, Object> toolMsg = new LinkedHashMap<>();
                toolMsg.put("role", "tool");
                toolMsg.put("tool_call_id", call.get("id"));
                toolMsg.put("name", name);
                toolMsg.put("content", result);
                history.add(toolMsg);
            }
        }
        return new Reply("(Stopped after " + MAX_STEPS + " tool steps without a final answer.)", steps,
                System.currentTimeMillis() - start);
    }

    @SuppressWarnings("unchecked")
    private static Map<String, Object> parseArgs(Object raw) {
        if (raw instanceof Map<?, ?> m) return (Map<String, Object>) m;      // Ollama native style
        if (raw instanceof String s && !s.isBlank()) {                        // OpenAI style: JSON string
            Object parsed = Json.parse(s);
            if (parsed instanceof Map<?, ?> m) return (Map<String, Object>) m;
        }
        return new LinkedHashMap<>();
    }

    /** Keep the context small: drop the oldest turns, always cutting at a user message. */
    private void trimHistory() {
        while (history.size() > 30) {
            history.remove(1);
            while (history.size() > 1 && !"user".equals(history.get(1).get("role"))) history.remove(1);
        }
    }

    public static String systemPrompt(List<String> genres) {
        return """
            You are MovieBot, a friendly chatbot for a movie database.
            Rules:
            - ALWAYS call a tool to get data. Answer ONLY from tool results; never invent movies, years, people or ratings.
            - search_movies: find/list movies by title, genre, director, actor, year.
            - get_movie_details: info about one specific movie (director, genres, actors, release date).
            - get_movie_ratings: rating statistics for one specific movie.
            - recommend_movies: suggestions; use similar_to when the user names a movie they liked.
            - You may call several tools in a row (e.g. find the director first, then search their other films).
            - Valid genres: %s. Map everyday words to these (scary -> Horror, funny -> Comedy, cartoon -> Animation, space -> Sci-Fi).
            - Ratings are averages of user scores on a 1-10 scale.
            - If a tool returns nothing or an error, say the movie isn't in the database.
            - For greetings or small talk, reply briefly and suggest what you can do.
            - Keep answers short and friendly. Use a bulleted list when listing several movies (title, year, rating).
            """.formatted(String.join(", ", genres));
    }

    private static Map<String, Object> msg(String role, String content) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("role", role);
        m.put("content", content);
        return m;
    }
}
