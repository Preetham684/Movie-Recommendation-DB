package edu.asu.cse412.movieagent;

import edu.asu.cse412.movieagent.agent.LlmClient;
import edu.asu.cse412.movieagent.tools.MovieTools;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import javax.sql.DataSource;
import java.util.List;
import java.util.Properties;

/** Wires the plain-Java agent classes into Spring. */
@Configuration
public class AgentConfig {

    @Bean
    public MovieTools movieTools(DataSource dataSource) {
        return new MovieTools(dataSource);
    }

    @Bean
    public LlmClient llmClient(Environment env) {
        Properties p = new Properties();
        for (String key : List.of("llm.provider", "ollama.url", "ollama.model",
                "azure.endpoint", "azure.deployment", "azure.apiVersion", "azure.apiKey")) {
            String v = env.getProperty(key);
            if (v != null) p.setProperty(key, v);
        }
        return LlmClient.fromConfig(p);
    }
}
