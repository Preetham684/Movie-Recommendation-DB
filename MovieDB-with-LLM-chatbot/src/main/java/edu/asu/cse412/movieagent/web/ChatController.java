package edu.asu.cse412.movieagent.web;

import edu.asu.cse412.movieagent.agent.Agent;
import edu.asu.cse412.movieagent.agent.LlmClient;
import edu.asu.cse412.movieagent.tools.MovieTools;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ChatController {
    private static final Logger log = LoggerFactory.getLogger(ChatController.class);
    private static final String AGENT_KEY = "movieAgent";

    private final MovieTools tools;
    private final LlmClient llm;
    private final String dbLabel;

    public ChatController(MovieTools tools, LlmClient llm, Environment env) {
        this.tools = tools;
        this.llm = llm;
        String url = env.getProperty("spring.datasource.url", "");
        this.dbLabel = url.startsWith("jdbc:h2") ? "H2 in-memory (PostgreSQL mode)" : "PostgreSQL";
        log.info("MovieBot ready | DB: {} ({}) | LLM: {}", dbLabel, url, llm.label);
    }

    /** The chat page. */
    @GetMapping("/")
    public String chat(Model model) {
        model.addAttribute("llmLabel", llm.label);
        model.addAttribute("dbLabel", dbLabel);
        return "chat";
    }

    /** User message in -> agent loop -> natural-language answer + tool trace out. */
    @PostMapping(value = "/api/chat", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> ask(@RequestBody Map<String, String> body, HttpSession session) {
        String message = body.getOrDefault("message", "").trim();
        if (message.isEmpty()) return ResponseEntity.badRequest().body(Map.<String, Object>of("error", "Empty message"));
        try {
            Agent.Reply reply = agentFor(session).ask(message);
            Map<String, Object> out = new LinkedHashMap<>();
            out.put("answer", reply.answer());
            out.put("steps", reply.steps());
            out.put("millis", reply.millis());
            return ResponseEntity.ok(out);
        } catch (Exception e) {
            log.error("Chat request failed for message: {}", message, e);
            String msg = e.getMessage() == null ? e.toString() : e.getMessage();
            return ResponseEntity.status(502).body(Map.<String, Object>of("error", msg));
        }
    }

    /** Clears the conversation memory for this browser. */
    @PostMapping("/api/reset")
    @ResponseBody
    public Map<String, Object> reset(HttpSession session) {
        session.removeAttribute(AGENT_KEY);
        return Map.of("ok", true);
    }

    /** Runs every tool directly (no LLM) - quick check that the database side works. */
    @GetMapping(value = "/api/selftest", produces = MediaType.TEXT_PLAIN_VALUE)
    @ResponseBody
    public String selfTest() {
        StringBuilder sb = new StringBuilder("Database: " + dbLabel + "\n\n");
        int failures = 0;
        // Use whatever movies are in the database so this works on any dataset
        String title = "x", genre = null;
        try {
            List<Map<String, Object>> all = tools.searchMovies(null, null, null, null, null, null);
            sb.append("Movies found: ").append(all.size()).append(all.size() == 15 ? "+" : "").append("\n\n");
            if (!all.isEmpty()) {
                title = String.valueOf(all.get(0).get("title"));
                Object g = all.get(0).get("genres");
                if (g != null) genre = g.toString().split(",")[0].trim();
            }
        } catch (SQLException e) {
            return sb.append("FAILED to list movies: ").append(e.getMessage()).toString();
        }
        tools.drainSqlLog();
        Object[][] cases = {
            {"search_movies", genre == null ? Map.of() : Map.of("genre", genre)},
            {"get_movie_details", Map.of("title", title)},
            {"get_movie_ratings", Map.of("title", title)},
            {"recommend_movies", Map.of("similar_to", title, "limit", 3)},
        };
        for (Object[] c : cases) {
            @SuppressWarnings("unchecked") Map<String, Object> args = (Map<String, Object>) c[1];
            sb.append("== ").append(c[0]).append(' ').append(args).append('\n');
            try {
                sb.append(tools.call((String) c[0], args)).append("\n\n");
            } catch (SQLException e) {
                failures++;
                sb.append("FAILED: ").append(e.getMessage()).append("\n\n");
            }
            tools.drainSqlLog();
        }
        return sb.append(failures == 0 ? "All tools OK." : failures + " tool(s) FAILED - see errors above and the console log.").toString();
    }

    private Agent agentFor(HttpSession session) throws SQLException {
        Agent agent = (Agent) session.getAttribute(AGENT_KEY);
        if (agent == null) {
            agent = new Agent(llm, tools, Agent.systemPrompt(tools.genres()));
            session.setAttribute(AGENT_KEY, agent);
        }
        return agent;
    }
}
