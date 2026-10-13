# Movie-Recommendation-DB
Our proposed application is an LLM-powered Movie Recommendation Database that allows 
users to search for movies and receive movie recommendations through natural-language 
requests. Instead of requiring users to manually search using predefined forms or filters, users 
will be able to ask the LLM agent questions about movies using everyday language. The LLM 
agent will interpret the request, select an appropriate predefined tool, and use that tool to 
retrieve information from the PostgreSQL database. 

The primary users of the application are people looking for movie information or 
recommendations. The application will allow users to search for movies, retrieve movie details, 
view movie ratings, and receive recommendations based on criteria such as genre, director, 
release date, or rating. 

The major data objects in the database are User, Movie, Genre, Person, Rating, and Role. User 
data includes information such as a username and email. Movie data includes information such 
as title, release date, and director. Genre data identifies the categories associated with movies. 
Person and Role data represent people connected to movies and the roles they have. Rating data 
connects users with movies and stores the rating value a user gives to a movie. 

Users will interact with these data objects through the LLM agent. When a user submits a 
natural-language request, the agent will determine the intent of the request and select the 
appropriate database tool. The selected tool will query PostgreSQL and return the relevant 
records. The LLM agent will then present those database results to the user in an understandable 
natural-language response. 

The agent will need to perform database operations such as SELECT queries, filtering, joins, 
sorting, and aggregation. For example, it may join Movie and Genre information to find movies 
belonging to a requested genre, filter movies according to release date or director, sort movies by 
ratings, or use stored ratings when generating movie recommendations.

#To import the DB successfully, follow the steps below: -
1) Download the file "Query_Movies_Export.sql" into your project folder.
2) Go to the folder where you downloaded PostgreSQL the first time.
3) Once you're there, run this via the terminal -> Get-Service *postgres*
4) Run this command after -> psql -U postgres -d movieDB -> enter your password
5) Next, run -> psql -U postgres -d movieDB -f "<path location to Query_Movies_Export.sql file>"
6) You have now downloaded the pre-existing database with the tables I filled in. You can view it by going to pgAdmin4.
