# MovieBot – LLM-Agent-Powered Movie Database (CSE 412, Group 24)

Ask questions about movies in plain English. An LLM agent (Azure OpenAI) picks a database tool, the tool runs
parameterized SQL on PostgreSQL, and the LLM answers in natural language. Each reply shows the tool calls and SQL used.

## Setup (once per machine)

1. **JDK 17+** and **Eclipse** (or IntelliJ / Spring Tool Suite).
2. **PostgreSQL**: create a database named `MovieDB` and load the team's SQL export into it (pgAdmin → Query Tool).
3. **Environment variables** (Command Prompt, then restart Eclipse):
   ```
   setx PGPASSWORD "your-postgres-password"
   setx AZURE_OPENAI_API_KEY "the-team-key"      (ask a teammate; never commit it)
   ```
   Only if your DB differs from the defaults: `setx DB_URL "jdbc:postgresql://localhost:5432/MovieDB"` and `setx DB_USER "postgres"`.
4. Eclipse: **File → Import → Maven → Existing Maven Projects** and select this folder.

## Run

- Eclipse: right-click `src/main/java/edu/asu/cse412/movieagent/MovieAgentApplication.java` → **Run As → Java Application**.
  Or double-click `run.bat`.
- Open **http://localhost:8080**.
- Check the DB side without the LLM: http://localhost:8080/api/selftest

**No PostgreSQL?** Add the program argument `--spring.profiles.active=h2` (or run `run.bat h2`). This uses an in-memory
database with the same tables and 38 sample movies.

Logs (every question, tool call, SQL query, error) appear in the console and in `logs/moviebot.log`.

## Code map

| File | Role |
|---|---|
| `web/ChatController.java` | Chat page `/`, `POST /api/chat`, `/api/reset`, `/api/selftest` |
| `agent/Agent.java` | Agent loop: LLM → tool calls → results → LLM → answer |
| `agent/LlmClient.java` | Tool-calling client for Azure OpenAI or Ollama |
| `tools/MovieTools.java` | `search_movies`, `get_movie_details`, `get_movie_ratings`, `recommend_movies` + SQL |
| `resources/application.properties` | PostgreSQL + Azure settings (defaults) |
| `resources/application-h2.properties` | In-memory H2 profile |
| `resources/sql/` | H2-only schema + sample data (never run against PostgreSQL) |
| `resources/templates/chat.html`, `static/` | Chat UI |
