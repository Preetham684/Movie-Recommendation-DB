package edu.asu.cse412.movieagent.agent;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Talks to any OpenAI-compatible chat-completions endpoint with tool calling.
 * Works with both Ollama (local, free) and Azure OpenAI - only the URL and auth header differ.
 */
public class LlmClient {
    private static final Logger log = LoggerFactory.getLogger(LlmClient.class);
    private final HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10)).build();
    private final String url;
    private final String model;      // Ollama needs it; Azure uses the deployment in the URL
    private final String apiKey;     // Azure only
    public final String label;

    private LlmClient(String url, String model, String apiKey, String label) {
        this.url = url;
        this.model = model;
        this.apiKey = apiKey;
        this.label = label;
    }

    public static LlmClient fromConfig(Properties p) {
        String provider = p.getProperty("llm.provider", "ollama").trim().toLowerCase();
        if (provider.equals("azure")) {
            // Accept a pasted URL like https://x.openai.azure.com/openai/v1 - keep only the base
            String endpoint = p.getProperty("azure.endpoint", "").trim().replaceAll("/openai(/.*)?$", "").replaceAll("/+$", "");
            String deployment = p.getProperty("azure.deployment", "gpt-4o-mini").trim();
            String version = p.getProperty("azure.apiVersion", "2024-10-21").trim();
            String key = System.getenv("AZURE_OPENAI_API_KEY");
            if (key == null || key.isBlank()) key = p.getProperty("azure.apiKey", "").trim();
            if (endpoint.isEmpty() || endpoint.contains("YOUR-RESOURCE") || key.isEmpty())
                throw new IllegalStateException("Azure selected but azure.endpoint / azure.apiKey are not set in config.properties");
            String u = endpoint + "/openai/deployments/" + deployment + "/chat/completions?api-version=" + version;
            return new LlmClient(u, null, key, "Azure OpenAI (" + deployment + ")");
        }
        String u = p.getProperty("ollama.url", "http://localhost:11434/v1/chat/completions").trim();
        String m = p.getProperty("ollama.model", "qwen2.5:7b").trim();
        return new LlmClient(u, m, null, "Ollama (" + m + ")");
    }

    /** Sends the conversation + tool definitions; returns the assistant "message" object. */
    @SuppressWarnings("unchecked")
    public Map<String, Object> chat(List<Map<String, Object>> messages, List<Map<String, Object>> tools)
            throws IOException, InterruptedException {
        Map<String, Object> body = new LinkedHashMap<>();
        if (model != null) body.put("model", model);
        body.put("messages", messages);
        body.put("tools", tools);
        if (model != null) body.put("temperature", 0);   // Ollama only: newer Azure reasoning models reject temperature

        HttpRequest.Builder rb = HttpRequest.newBuilder(URI.create(url))
                .timeout(Duration.ofMinutes(3))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(Json.stringify(body), StandardCharsets.UTF_8));
        if (apiKey != null) rb.header("api-key", apiKey);

        HttpResponse<String> r;
        try {
            r = http.send(rb.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
        } catch (java.net.ConnectException e) {
            throw new IOException("Can't reach the LLM at " + url + " - is Ollama running? (start the Ollama app, or run: ollama serve)", e);
        }
        log.debug("LLM POST {} -> HTTP {}", url.replaceAll("api-key=[^&]*", ""), r.statusCode());
        if (r.statusCode() / 100 != 2) {
            log.error("LLM error HTTP {}: {}", r.statusCode(), r.body());
            throw new IOException("LLM returned HTTP " + r.statusCode() + ": " + r.body());
        }

        Map<String, Object> resp = (Map<String, Object>) Json.parse(r.body());
        List<Object> choices = (List<Object>) resp.get("choices");
        return (Map<String, Object>) ((Map<String, Object>) choices.get(0)).get("message");
    }
}
