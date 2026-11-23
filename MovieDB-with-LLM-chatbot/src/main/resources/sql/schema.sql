-- CSE 412 Group 24 - Movie Recommendation DB schema (matches the team's PostgreSQL database).
-- Used ONLY for the H2 in-memory mode. With the "postgres" profile this script is NOT run,
-- so your real PostgreSQL tables and data are never touched.
-- (Your PostgreSQL uses the "name" type for text columns; VARCHAR is used here so H2 can run it.)

DROP TABLE IF EXISTS rating, role, movie_genre, genre, person, movie, "user" CASCADE;

CREATE TABLE "user" (
    user_id    SERIAL PRIMARY KEY,
    username  VARCHAR(63) NOT NULL UNIQUE,
    email     VARCHAR(63) NOT NULL UNIQUE,
    password  VARCHAR(63) NOT NULL
);

CREATE TABLE movie (
    movie_id       SERIAL PRIMARY KEY,
    title         VARCHAR(63) NOT NULL,
    release_date  DATE NOT NULL,
    director      VARCHAR(63) NOT NULL
);

CREATE TABLE genre (
    genre_id  SERIAL PRIMARY KEY,
    name     VARCHAR(63) NOT NULL UNIQUE
);

CREATE TABLE movie_genre (
    movie_id  INT NOT NULL REFERENCES movie(movie_id),
    genre_id  INT NOT NULL REFERENCES genre(genre_id)
);

CREATE TABLE person (
    person_id     SERIAL PRIMARY KEY,
    person_name  VARCHAR(63) NOT NULL UNIQUE,
    dob          DATE
);

CREATE TABLE role (
    role_id     SERIAL PRIMARY KEY,
    movie_id    INT NOT NULL REFERENCES movie(movie_id),
    person_id   INT NOT NULL REFERENCES person(person_id),
    role_type  VARCHAR(63) NOT NULL
);

CREATE TABLE rating (
    rating_id      SERIAL PRIMARY KEY,
    rating_value  INT NOT NULL,
    movie_id       INT NOT NULL REFERENCES movie(movie_id),
    user_id        INT NOT NULL REFERENCES "user"(user_id)
);
