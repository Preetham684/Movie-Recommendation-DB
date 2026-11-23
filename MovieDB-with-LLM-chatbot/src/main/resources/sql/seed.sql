-- Sample data for H2 in-memory mode (generated). Ratings are synthetic demo values, integers 1-10.

INSERT INTO genre (name) VALUES ('Action'), ('Adventure'), ('Animation'), ('Comedy'), ('Crime'), ('Drama'), ('Family'), ('Fantasy'), ('History'), ('Horror'), ('Music'), ('Musical'), ('Romance'), ('Sci-Fi'), ('Thriller'), ('War'), ('Western');
INSERT INTO person (person_name) VALUES
  ('Christopher Nolan'),
  ('Leonardo DiCaprio'),
  ('Joseph Gordon-Levitt'),
  ('Matthew McConaughey'),
  ('Anne Hathaway'),
  ('Christian Bale'),
  ('Heath Ledger'),
  ('Cillian Murphy'),
  ('Emily Blunt'),
  ('Fionn Whitehead'),
  ('Tom Hardy'),
  ('Quentin Tarantino'),
  ('John Travolta'),
  ('Samuel L. Jackson'),
  ('Jamie Foxx'),
  ('Christoph Waltz'),
  ('Brad Pitt'),
  ('Bong Joon-ho'),
  ('Song Kang-ho'),
  ('Choi Woo-shik'),
  ('Jordan Peele'),
  ('Daniel Kaluuya'),
  ('Allison Williams'),
  ('Lupita Nyong''o'),
  ('Winston Duke'),
  ('Keke Palmer'),
  ('Ari Aster'),
  ('Toni Collette'),
  ('Alex Wolff'),
  ('Stanley Kubrick'),
  ('Jack Nicholson'),
  ('Shelley Duvall'),
  ('Keir Dullea'),
  ('Gary Lockwood'),
  ('Denis Villeneuve'),
  ('Amy Adams'),
  ('Jeremy Renner'),
  ('Timothée Chalamet'),
  ('Rebecca Ferguson'),
  ('Ryan Gosling'),
  ('Harrison Ford'),
  ('Lana Wachowski'),
  ('Lilly Wachowski'),
  ('Keanu Reeves'),
  ('Laurence Fishburne'),
  ('Hayao Miyazaki'),
  ('Rumi Hiiragi'),
  ('Miyu Irino'),
  ('Noriko Hidaka'),
  ('Chika Sakamoto'),
  ('John Lasseter'),
  ('Tom Hanks'),
  ('Tim Allen'),
  ('Pete Docter'),
  ('Ed Asner'),
  ('Jordan Nagai'),
  ('Amy Poehler'),
  ('Phyllis Smith'),
  ('Francis Ford Coppola'),
  ('Marlon Brando'),
  ('Al Pacino'),
  ('Martin Scorsese'),
  ('Ray Liotta'),
  ('Robert De Niro'),
  ('Jonah Hill'),
  ('Damien Chazelle'),
  ('Emma Stone'),
  ('Miles Teller'),
  ('J.K. Simmons'),
  ('George Miller'),
  ('Charlize Theron'),
  ('Wes Anderson'),
  ('Ralph Fiennes'),
  ('Tony Revolori'),
  ('Daniel Kwan'),
  ('Daniel Scheinert'),
  ('Michelle Yeoh'),
  ('Ke Huy Quan'),
  ('Frank Darabont'),
  ('Tim Robbins'),
  ('Morgan Freeman'),
  ('James Cameron'),
  ('Kate Winslet'),
  ('Sam Worthington'),
  ('Zoe Saldaña'),
  ('Greta Gerwig'),
  ('Margot Robbie'),
  ('Saoirse Ronan'),
  ('Florence Pugh'),
  ('John Krasinski');
INSERT INTO "user" (username, email, password) VALUES
  ('preetham', 'preetham@example.com', 'demo'),
  ('brianna', 'brianna@example.com', 'demo'),
  ('meghana', 'meghana@example.com', 'demo'),
  ('kevin', 'kevin@example.com', 'demo'),
  ('alex_m', 'alex_m@example.com', 'demo'),
  ('jordan_k', 'jordan_k@example.com', 'demo'),
  ('sam_r', 'sam_r@example.com', 'demo'),
  ('taylor_b', 'taylor_b@example.com', 'demo'),
  ('chris_p', 'chris_p@example.com', 'demo'),
  ('dana_w', 'dana_w@example.com', 'demo');

-- 1. Inception
INSERT INTO movie (movie_id, title, release_date, director) VALUES (1, 'Inception', '2010-07-16', 'Christopher Nolan');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 1, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 1, genre_id FROM genre WHERE name = 'Action';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 1, genre_id FROM genre WHERE name = 'Thriller';
INSERT INTO role (movie_id, person_id, role_type) SELECT 1, person_id, 'Director' FROM person WHERE person_name = 'Christopher Nolan';
INSERT INTO role (movie_id, person_id, role_type) SELECT 1, person_id, 'Actor' FROM person WHERE person_name = 'Leonardo DiCaprio';
INSERT INTO role (movie_id, person_id, role_type) SELECT 1, person_id, 'Actor' FROM person WHERE person_name = 'Joseph Gordon-Levitt';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 1, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (7, 1, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (9, 1, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 1, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (10, 1, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (10, 1, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (8, 1, (SELECT user_id FROM "user" WHERE username = 'alex_m'));

-- 2. Interstellar
INSERT INTO movie (movie_id, title, release_date, director) VALUES (2, 'Interstellar', '2014-11-07', 'Christopher Nolan');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 2, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 2, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 2, genre_id FROM genre WHERE name = 'Adventure';
INSERT INTO role (movie_id, person_id, role_type) SELECT 2, person_id, 'Director' FROM person WHERE person_name = 'Christopher Nolan';
INSERT INTO role (movie_id, person_id, role_type) SELECT 2, person_id, 'Actor' FROM person WHERE person_name = 'Matthew McConaughey';
INSERT INTO role (movie_id, person_id, role_type) SELECT 2, person_id, 'Actor' FROM person WHERE person_name = 'Anne Hathaway';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 2, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (8, 2, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (9, 2, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 2, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (9, 2, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 2, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (9, 2, (SELECT user_id FROM "user" WHERE username = 'brianna'));

-- 3. The Dark Knight
INSERT INTO movie (movie_id, title, release_date, director) VALUES (3, 'The Dark Knight', '2008-07-18', 'Christopher Nolan');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 3, genre_id FROM genre WHERE name = 'Action';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 3, genre_id FROM genre WHERE name = 'Crime';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 3, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 3, person_id, 'Director' FROM person WHERE person_name = 'Christopher Nolan';
INSERT INTO role (movie_id, person_id, role_type) SELECT 3, person_id, 'Actor' FROM person WHERE person_name = 'Christian Bale';
INSERT INTO role (movie_id, person_id, role_type) SELECT 3, person_id, 'Actor' FROM person WHERE person_name = 'Heath Ledger';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 3, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (9, 3, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 3, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (9, 3, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (9, 3, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (8, 3, (SELECT user_id FROM "user" WHERE username = 'alex_m'));

-- 4. Oppenheimer
INSERT INTO movie (movie_id, title, release_date, director) VALUES (4, 'Oppenheimer', '2023-07-21', 'Christopher Nolan');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 4, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 4, genre_id FROM genre WHERE name = 'History';
INSERT INTO role (movie_id, person_id, role_type) SELECT 4, person_id, 'Director' FROM person WHERE person_name = 'Christopher Nolan';
INSERT INTO role (movie_id, person_id, role_type) SELECT 4, person_id, 'Actor' FROM person WHERE person_name = 'Cillian Murphy';
INSERT INTO role (movie_id, person_id, role_type) SELECT 4, person_id, 'Actor' FROM person WHERE person_name = 'Emily Blunt';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 4, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (7, 4, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 4, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (9, 4, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 4, (SELECT user_id FROM "user" WHERE username = 'alex_m'));

-- 5. Dunkirk
INSERT INTO movie (movie_id, title, release_date, director) VALUES (5, 'Dunkirk', '2017-07-21', 'Christopher Nolan');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 5, genre_id FROM genre WHERE name = 'War';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 5, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 5, genre_id FROM genre WHERE name = 'History';
INSERT INTO role (movie_id, person_id, role_type) SELECT 5, person_id, 'Director' FROM person WHERE person_name = 'Christopher Nolan';
INSERT INTO role (movie_id, person_id, role_type) SELECT 5, person_id, 'Actor' FROM person WHERE person_name = 'Fionn Whitehead';
INSERT INTO role (movie_id, person_id, role_type) SELECT 5, person_id, 'Actor' FROM person WHERE person_name = 'Tom Hardy';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 5, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (6, 5, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (7, 5, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (8, 5, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 5, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (8, 5, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 5, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (8, 5, (SELECT user_id FROM "user" WHERE username = 'jordan_k'));

-- 6. Pulp Fiction
INSERT INTO movie (movie_id, title, release_date, director) VALUES (6, 'Pulp Fiction', '1994-10-14', 'Quentin Tarantino');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 6, genre_id FROM genre WHERE name = 'Crime';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 6, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 6, person_id, 'Director' FROM person WHERE person_name = 'Quentin Tarantino';
INSERT INTO role (movie_id, person_id, role_type) SELECT 6, person_id, 'Actor' FROM person WHERE person_name = 'John Travolta';
INSERT INTO role (movie_id, person_id, role_type) SELECT 6, person_id, 'Actor' FROM person WHERE person_name = 'Samuel L. Jackson';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 6, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 6, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (10, 6, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (8, 6, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (8, 6, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (9, 6, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (7, 6, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 6, (SELECT user_id FROM "user" WHERE username = 'preetham'));

-- 7. Django Unchained
INSERT INTO movie (movie_id, title, release_date, director) VALUES (7, 'Django Unchained', '2012-12-25', 'Quentin Tarantino');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 7, genre_id FROM genre WHERE name = 'Western';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 7, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 7, person_id, 'Director' FROM person WHERE person_name = 'Quentin Tarantino';
INSERT INTO role (movie_id, person_id, role_type) SELECT 7, person_id, 'Actor' FROM person WHERE person_name = 'Jamie Foxx';
INSERT INTO role (movie_id, person_id, role_type) SELECT 7, person_id, 'Actor' FROM person WHERE person_name = 'Christoph Waltz';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 7, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (7, 7, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (7, 7, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 7, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 7, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 7, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (7, 7, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (8, 7, (SELECT user_id FROM "user" WHERE username = 'chris_p'));

-- 8. Once Upon a Time in Hollywood
INSERT INTO movie (movie_id, title, release_date, director) VALUES (8, 'Once Upon a Time in Hollywood', '2019-07-26', 'Quentin Tarantino');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 8, genre_id FROM genre WHERE name = 'Comedy';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 8, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 8, person_id, 'Director' FROM person WHERE person_name = 'Quentin Tarantino';
INSERT INTO role (movie_id, person_id, role_type) SELECT 8, person_id, 'Actor' FROM person WHERE person_name = 'Leonardo DiCaprio';
INSERT INTO role (movie_id, person_id, role_type) SELECT 8, person_id, 'Actor' FROM person WHERE person_name = 'Brad Pitt';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 8, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 8, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (7, 8, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (6, 8, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 8, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (6, 8, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (8, 8, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (7, 8, (SELECT user_id FROM "user" WHERE username = 'sam_r'));

-- 9. Parasite
INSERT INTO movie (movie_id, title, release_date, director) VALUES (9, 'Parasite', '2019-05-30', 'Bong Joon-ho');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 9, genre_id FROM genre WHERE name = 'Thriller';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 9, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 9, genre_id FROM genre WHERE name = 'Comedy';
INSERT INTO role (movie_id, person_id, role_type) SELECT 9, person_id, 'Director' FROM person WHERE person_name = 'Bong Joon-ho';
INSERT INTO role (movie_id, person_id, role_type) SELECT 9, person_id, 'Actor' FROM person WHERE person_name = 'Song Kang-ho';
INSERT INTO role (movie_id, person_id, role_type) SELECT 9, person_id, 'Actor' FROM person WHERE person_name = 'Choi Woo-shik';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 9, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (9, 9, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (9, 9, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 9, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (8, 9, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (7, 9, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 9, (SELECT user_id FROM "user" WHERE username = 'taylor_b'));

-- 10. Get Out
INSERT INTO movie (movie_id, title, release_date, director) VALUES (10, 'Get Out', '2017-02-24', 'Jordan Peele');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 10, genre_id FROM genre WHERE name = 'Horror';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 10, genre_id FROM genre WHERE name = 'Thriller';
INSERT INTO role (movie_id, person_id, role_type) SELECT 10, person_id, 'Director' FROM person WHERE person_name = 'Jordan Peele';
INSERT INTO role (movie_id, person_id, role_type) SELECT 10, person_id, 'Actor' FROM person WHERE person_name = 'Daniel Kaluuya';
INSERT INTO role (movie_id, person_id, role_type) SELECT 10, person_id, 'Actor' FROM person WHERE person_name = 'Allison Williams';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (7, 10, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (9, 10, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 10, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 10, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (7, 10, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (7, 10, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 10, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (9, 10, (SELECT user_id FROM "user" WHERE username = 'jordan_k'));

-- 11. Us
INSERT INTO movie (movie_id, title, release_date, director) VALUES (11, 'Us', '2019-03-22', 'Jordan Peele');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 11, genre_id FROM genre WHERE name = 'Horror';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 11, genre_id FROM genre WHERE name = 'Thriller';
INSERT INTO role (movie_id, person_id, role_type) SELECT 11, person_id, 'Director' FROM person WHERE person_name = 'Jordan Peele';
INSERT INTO role (movie_id, person_id, role_type) SELECT 11, person_id, 'Actor' FROM person WHERE person_name = 'Lupita Nyong''o';
INSERT INTO role (movie_id, person_id, role_type) SELECT 11, person_id, 'Actor' FROM person WHERE person_name = 'Winston Duke';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (7, 11, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 11, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (6, 11, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (7, 11, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (6, 11, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (5, 11, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (7, 11, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (6, 11, (SELECT user_id FROM "user" WHERE username = 'preetham'));

-- 12. Nope
INSERT INTO movie (movie_id, title, release_date, director) VALUES (12, 'Nope', '2022-07-22', 'Jordan Peele');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 12, genre_id FROM genre WHERE name = 'Horror';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 12, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO role (movie_id, person_id, role_type) SELECT 12, person_id, 'Director' FROM person WHERE person_name = 'Jordan Peele';
INSERT INTO role (movie_id, person_id, role_type) SELECT 12, person_id, 'Actor' FROM person WHERE person_name = 'Daniel Kaluuya';
INSERT INTO role (movie_id, person_id, role_type) SELECT 12, person_id, 'Actor' FROM person WHERE person_name = 'Keke Palmer';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (6, 12, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (8, 12, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (7, 12, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (8, 12, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (7, 12, (SELECT user_id FROM "user" WHERE username = 'chris_p'));

-- 13. Hereditary
INSERT INTO movie (movie_id, title, release_date, director) VALUES (13, 'Hereditary', '2018-06-08', 'Ari Aster');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 13, genre_id FROM genre WHERE name = 'Horror';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 13, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 13, person_id, 'Director' FROM person WHERE person_name = 'Ari Aster';
INSERT INTO role (movie_id, person_id, role_type) SELECT 13, person_id, 'Actor' FROM person WHERE person_name = 'Toni Collette';
INSERT INTO role (movie_id, person_id, role_type) SELECT 13, person_id, 'Actor' FROM person WHERE person_name = 'Alex Wolff';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 13, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (8, 13, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (8, 13, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (7, 13, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (7, 13, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (6, 13, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 13, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (7, 13, (SELECT user_id FROM "user" WHERE username = 'alex_m'));

-- 14. The Shining
INSERT INTO movie (movie_id, title, release_date, director) VALUES (14, 'The Shining', '1980-05-23', 'Stanley Kubrick');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 14, genre_id FROM genre WHERE name = 'Horror';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 14, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 14, person_id, 'Director' FROM person WHERE person_name = 'Stanley Kubrick';
INSERT INTO role (movie_id, person_id, role_type) SELECT 14, person_id, 'Actor' FROM person WHERE person_name = 'Jack Nicholson';
INSERT INTO role (movie_id, person_id, role_type) SELECT 14, person_id, 'Actor' FROM person WHERE person_name = 'Shelley Duvall';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 14, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (9, 14, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 14, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (9, 14, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (9, 14, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 14, (SELECT user_id FROM "user" WHERE username = 'sam_r'));

-- 15. 2001: A Space Odyssey
INSERT INTO movie (movie_id, title, release_date, director) VALUES (15, '2001: A Space Odyssey', '1968-04-03', 'Stanley Kubrick');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 15, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 15, genre_id FROM genre WHERE name = 'Adventure';
INSERT INTO role (movie_id, person_id, role_type) SELECT 15, person_id, 'Director' FROM person WHERE person_name = 'Stanley Kubrick';
INSERT INTO role (movie_id, person_id, role_type) SELECT 15, person_id, 'Actor' FROM person WHERE person_name = 'Keir Dullea';
INSERT INTO role (movie_id, person_id, role_type) SELECT 15, person_id, 'Actor' FROM person WHERE person_name = 'Gary Lockwood';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 15, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (9, 15, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 15, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 15, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 15, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (7, 15, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (7, 15, (SELECT user_id FROM "user" WHERE username = 'chris_p'));

-- 16. Arrival
INSERT INTO movie (movie_id, title, release_date, director) VALUES (16, 'Arrival', '2016-11-11', 'Denis Villeneuve');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 16, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 16, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 16, person_id, 'Director' FROM person WHERE person_name = 'Denis Villeneuve';
INSERT INTO role (movie_id, person_id, role_type) SELECT 16, person_id, 'Actor' FROM person WHERE person_name = 'Amy Adams';
INSERT INTO role (movie_id, person_id, role_type) SELECT 16, person_id, 'Actor' FROM person WHERE person_name = 'Jeremy Renner';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (7, 16, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (9, 16, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (9, 16, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 16, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (7, 16, (SELECT user_id FROM "user" WHERE username = 'sam_r'));

-- 17. Dune
INSERT INTO movie (movie_id, title, release_date, director) VALUES (17, 'Dune', '2021-10-22', 'Denis Villeneuve');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 17, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 17, genre_id FROM genre WHERE name = 'Adventure';
INSERT INTO role (movie_id, person_id, role_type) SELECT 17, person_id, 'Director' FROM person WHERE person_name = 'Denis Villeneuve';
INSERT INTO role (movie_id, person_id, role_type) SELECT 17, person_id, 'Actor' FROM person WHERE person_name = 'Timothée Chalamet';
INSERT INTO role (movie_id, person_id, role_type) SELECT 17, person_id, 'Actor' FROM person WHERE person_name = 'Rebecca Ferguson';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 17, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 17, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (8, 17, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (8, 17, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (9, 17, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 17, (SELECT user_id FROM "user" WHERE username = 'alex_m'));

-- 18. Blade Runner 2049
INSERT INTO movie (movie_id, title, release_date, director) VALUES (18, 'Blade Runner 2049', '2017-10-06', 'Denis Villeneuve');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 18, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 18, genre_id FROM genre WHERE name = 'Thriller';
INSERT INTO role (movie_id, person_id, role_type) SELECT 18, person_id, 'Director' FROM person WHERE person_name = 'Denis Villeneuve';
INSERT INTO role (movie_id, person_id, role_type) SELECT 18, person_id, 'Actor' FROM person WHERE person_name = 'Ryan Gosling';
INSERT INTO role (movie_id, person_id, role_type) SELECT 18, person_id, 'Actor' FROM person WHERE person_name = 'Harrison Ford';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (7, 18, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (7, 18, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (7, 18, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (7, 18, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (7, 18, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 18, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 18, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (8, 18, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (8, 18, (SELECT user_id FROM "user" WHERE username = 'jordan_k'));

-- 19. The Matrix
INSERT INTO movie (movie_id, title, release_date, director) VALUES (19, 'The Matrix', '1999-03-31', 'Lana Wachowski & Lilly Wachowski');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 19, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 19, genre_id FROM genre WHERE name = 'Action';
INSERT INTO role (movie_id, person_id, role_type) SELECT 19, person_id, 'Director' FROM person WHERE person_name = 'Lana Wachowski';
INSERT INTO role (movie_id, person_id, role_type) SELECT 19, person_id, 'Director' FROM person WHERE person_name = 'Lilly Wachowski';
INSERT INTO role (movie_id, person_id, role_type) SELECT 19, person_id, 'Actor' FROM person WHERE person_name = 'Keanu Reeves';
INSERT INTO role (movie_id, person_id, role_type) SELECT 19, person_id, 'Actor' FROM person WHERE person_name = 'Laurence Fishburne';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 19, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (9, 19, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 19, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 19, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (8, 19, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (9, 19, (SELECT user_id FROM "user" WHERE username = 'sam_r'));

-- 20. Spirited Away
INSERT INTO movie (movie_id, title, release_date, director) VALUES (20, 'Spirited Away', '2001-07-20', 'Hayao Miyazaki');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 20, genre_id FROM genre WHERE name = 'Animation';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 20, genre_id FROM genre WHERE name = 'Fantasy';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 20, genre_id FROM genre WHERE name = 'Family';
INSERT INTO role (movie_id, person_id, role_type) SELECT 20, person_id, 'Director' FROM person WHERE person_name = 'Hayao Miyazaki';
INSERT INTO role (movie_id, person_id, role_type) SELECT 20, person_id, 'Actor' FROM person WHERE person_name = 'Rumi Hiiragi';
INSERT INTO role (movie_id, person_id, role_type) SELECT 20, person_id, 'Actor' FROM person WHERE person_name = 'Miyu Irino';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 20, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (9, 20, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (8, 20, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (8, 20, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (8, 20, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (8, 20, (SELECT user_id FROM "user" WHERE username = 'kevin'));

-- 21. My Neighbor Totoro
INSERT INTO movie (movie_id, title, release_date, director) VALUES (21, 'My Neighbor Totoro', '1988-04-16', 'Hayao Miyazaki');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 21, genre_id FROM genre WHERE name = 'Animation';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 21, genre_id FROM genre WHERE name = 'Family';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 21, genre_id FROM genre WHERE name = 'Fantasy';
INSERT INTO role (movie_id, person_id, role_type) SELECT 21, person_id, 'Director' FROM person WHERE person_name = 'Hayao Miyazaki';
INSERT INTO role (movie_id, person_id, role_type) SELECT 21, person_id, 'Actor' FROM person WHERE person_name = 'Noriko Hidaka';
INSERT INTO role (movie_id, person_id, role_type) SELECT 21, person_id, 'Actor' FROM person WHERE person_name = 'Chika Sakamoto';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 21, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (9, 21, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 21, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (8, 21, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (8, 21, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (9, 21, (SELECT user_id FROM "user" WHERE username = 'chris_p'));

-- 22. Toy Story
INSERT INTO movie (movie_id, title, release_date, director) VALUES (22, 'Toy Story', '1995-11-22', 'John Lasseter');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 22, genre_id FROM genre WHERE name = 'Animation';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 22, genre_id FROM genre WHERE name = 'Family';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 22, genre_id FROM genre WHERE name = 'Comedy';
INSERT INTO role (movie_id, person_id, role_type) SELECT 22, person_id, 'Director' FROM person WHERE person_name = 'John Lasseter';
INSERT INTO role (movie_id, person_id, role_type) SELECT 22, person_id, 'Actor' FROM person WHERE person_name = 'Tom Hanks';
INSERT INTO role (movie_id, person_id, role_type) SELECT 22, person_id, 'Actor' FROM person WHERE person_name = 'Tim Allen';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 22, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (7, 22, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (9, 22, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (8, 22, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 22, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (9, 22, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (7, 22, (SELECT user_id FROM "user" WHERE username = 'alex_m'));

-- 23. Up
INSERT INTO movie (movie_id, title, release_date, director) VALUES (23, 'Up', '2009-05-29', 'Pete Docter');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 23, genre_id FROM genre WHERE name = 'Animation';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 23, genre_id FROM genre WHERE name = 'Family';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 23, genre_id FROM genre WHERE name = 'Adventure';
INSERT INTO role (movie_id, person_id, role_type) SELECT 23, person_id, 'Director' FROM person WHERE person_name = 'Pete Docter';
INSERT INTO role (movie_id, person_id, role_type) SELECT 23, person_id, 'Actor' FROM person WHERE person_name = 'Ed Asner';
INSERT INTO role (movie_id, person_id, role_type) SELECT 23, person_id, 'Actor' FROM person WHERE person_name = 'Jordan Nagai';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 23, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (7, 23, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (7, 23, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 23, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 23, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 23, (SELECT user_id FROM "user" WHERE username = 'brianna'));

-- 24. Inside Out
INSERT INTO movie (movie_id, title, release_date, director) VALUES (24, 'Inside Out', '2015-06-19', 'Pete Docter');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 24, genre_id FROM genre WHERE name = 'Animation';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 24, genre_id FROM genre WHERE name = 'Family';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 24, genre_id FROM genre WHERE name = 'Comedy';
INSERT INTO role (movie_id, person_id, role_type) SELECT 24, person_id, 'Director' FROM person WHERE person_name = 'Pete Docter';
INSERT INTO role (movie_id, person_id, role_type) SELECT 24, person_id, 'Actor' FROM person WHERE person_name = 'Amy Poehler';
INSERT INTO role (movie_id, person_id, role_type) SELECT 24, person_id, 'Actor' FROM person WHERE person_name = 'Phyllis Smith';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (7, 24, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (7, 24, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 24, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (8, 24, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 24, (SELECT user_id FROM "user" WHERE username = 'alex_m'));

-- 25. The Godfather
INSERT INTO movie (movie_id, title, release_date, director) VALUES (25, 'The Godfather', '1972-03-24', 'Francis Ford Coppola');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 25, genre_id FROM genre WHERE name = 'Crime';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 25, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 25, person_id, 'Director' FROM person WHERE person_name = 'Francis Ford Coppola';
INSERT INTO role (movie_id, person_id, role_type) SELECT 25, person_id, 'Actor' FROM person WHERE person_name = 'Marlon Brando';
INSERT INTO role (movie_id, person_id, role_type) SELECT 25, person_id, 'Actor' FROM person WHERE person_name = 'Al Pacino';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 25, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (9, 25, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (9, 25, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 25, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (8, 25, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (10, 25, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (9, 25, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (10, 25, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (9, 25, (SELECT user_id FROM "user" WHERE username = 'preetham'));

-- 26. Goodfellas
INSERT INTO movie (movie_id, title, release_date, director) VALUES (26, 'Goodfellas', '1990-09-19', 'Martin Scorsese');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 26, genre_id FROM genre WHERE name = 'Crime';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 26, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 26, person_id, 'Director' FROM person WHERE person_name = 'Martin Scorsese';
INSERT INTO role (movie_id, person_id, role_type) SELECT 26, person_id, 'Actor' FROM person WHERE person_name = 'Ray Liotta';
INSERT INTO role (movie_id, person_id, role_type) SELECT 26, person_id, 'Actor' FROM person WHERE person_name = 'Robert De Niro';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 26, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (9, 26, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (9, 26, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (10, 26, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (10, 26, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (9, 26, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (10, 26, (SELECT user_id FROM "user" WHERE username = 'dana_w'));

-- 27. The Wolf of Wall Street
INSERT INTO movie (movie_id, title, release_date, director) VALUES (27, 'The Wolf of Wall Street', '2013-12-25', 'Martin Scorsese');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 27, genre_id FROM genre WHERE name = 'Comedy';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 27, genre_id FROM genre WHERE name = 'Crime';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 27, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 27, person_id, 'Director' FROM person WHERE person_name = 'Martin Scorsese';
INSERT INTO role (movie_id, person_id, role_type) SELECT 27, person_id, 'Actor' FROM person WHERE person_name = 'Leonardo DiCaprio';
INSERT INTO role (movie_id, person_id, role_type) SELECT 27, person_id, 'Actor' FROM person WHERE person_name = 'Jonah Hill';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (7, 27, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (8, 27, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (9, 27, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (7, 27, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 27, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (8, 27, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (7, 27, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (9, 27, (SELECT user_id FROM "user" WHERE username = 'dana_w'));

-- 28. La La Land
INSERT INTO movie (movie_id, title, release_date, director) VALUES (28, 'La La Land', '2016-12-09', 'Damien Chazelle');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 28, genre_id FROM genre WHERE name = 'Romance';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 28, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 28, genre_id FROM genre WHERE name = 'Musical';
INSERT INTO role (movie_id, person_id, role_type) SELECT 28, person_id, 'Director' FROM person WHERE person_name = 'Damien Chazelle';
INSERT INTO role (movie_id, person_id, role_type) SELECT 28, person_id, 'Actor' FROM person WHERE person_name = 'Ryan Gosling';
INSERT INTO role (movie_id, person_id, role_type) SELECT 28, person_id, 'Actor' FROM person WHERE person_name = 'Emma Stone';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 28, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 28, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (9, 28, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (9, 28, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (8, 28, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (7, 28, (SELECT user_id FROM "user" WHERE username = 'kevin'));

-- 29. Whiplash
INSERT INTO movie (movie_id, title, release_date, director) VALUES (29, 'Whiplash', '2014-10-10', 'Damien Chazelle');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 29, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 29, genre_id FROM genre WHERE name = 'Music';
INSERT INTO role (movie_id, person_id, role_type) SELECT 29, person_id, 'Director' FROM person WHERE person_name = 'Damien Chazelle';
INSERT INTO role (movie_id, person_id, role_type) SELECT 29, person_id, 'Actor' FROM person WHERE person_name = 'Miles Teller';
INSERT INTO role (movie_id, person_id, role_type) SELECT 29, person_id, 'Actor' FROM person WHERE person_name = 'J.K. Simmons';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 29, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (9, 29, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (7, 29, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (8, 29, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (9, 29, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (9, 29, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 29, (SELECT user_id FROM "user" WHERE username = 'preetham'));

-- 30. Mad Max: Fury Road
INSERT INTO movie (movie_id, title, release_date, director) VALUES (30, 'Mad Max: Fury Road', '2015-05-15', 'George Miller');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 30, genre_id FROM genre WHERE name = 'Action';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 30, genre_id FROM genre WHERE name = 'Adventure';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 30, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO role (movie_id, person_id, role_type) SELECT 30, person_id, 'Director' FROM person WHERE person_name = 'George Miller';
INSERT INTO role (movie_id, person_id, role_type) SELECT 30, person_id, 'Actor' FROM person WHERE person_name = 'Tom Hardy';
INSERT INTO role (movie_id, person_id, role_type) SELECT 30, person_id, 'Actor' FROM person WHERE person_name = 'Charlize Theron';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 30, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 30, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (7, 30, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 30, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (8, 30, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 30, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (7, 30, (SELECT user_id FROM "user" WHERE username = 'chris_p'));

-- 31. The Grand Budapest Hotel
INSERT INTO movie (movie_id, title, release_date, director) VALUES (31, 'The Grand Budapest Hotel', '2014-03-28', 'Wes Anderson');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 31, genre_id FROM genre WHERE name = 'Comedy';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 31, genre_id FROM genre WHERE name = 'Adventure';
INSERT INTO role (movie_id, person_id, role_type) SELECT 31, person_id, 'Director' FROM person WHERE person_name = 'Wes Anderson';
INSERT INTO role (movie_id, person_id, role_type) SELECT 31, person_id, 'Actor' FROM person WHERE person_name = 'Ralph Fiennes';
INSERT INTO role (movie_id, person_id, role_type) SELECT 31, person_id, 'Actor' FROM person WHERE person_name = 'Tony Revolori';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (9, 31, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (7, 31, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (9, 31, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (7, 31, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (9, 31, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (7, 31, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (8, 31, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (9, 31, (SELECT user_id FROM "user" WHERE username = 'brianna'));

-- 32. Everything Everywhere All at Once
INSERT INTO movie (movie_id, title, release_date, director) VALUES (32, 'Everything Everywhere All at Once', '2022-03-25', 'Daniel Kwan & Daniel Scheinert');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 32, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 32, genre_id FROM genre WHERE name = 'Comedy';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 32, genre_id FROM genre WHERE name = 'Action';
INSERT INTO role (movie_id, person_id, role_type) SELECT 32, person_id, 'Director' FROM person WHERE person_name = 'Daniel Kwan';
INSERT INTO role (movie_id, person_id, role_type) SELECT 32, person_id, 'Director' FROM person WHERE person_name = 'Daniel Scheinert';
INSERT INTO role (movie_id, person_id, role_type) SELECT 32, person_id, 'Actor' FROM person WHERE person_name = 'Michelle Yeoh';
INSERT INTO role (movie_id, person_id, role_type) SELECT 32, person_id, 'Actor' FROM person WHERE person_name = 'Ke Huy Quan';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (6, 32, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (7, 32, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (6, 32, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 32, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (9, 32, (SELECT user_id FROM "user" WHERE username = 'meghana'));

-- 33. The Shawshank Redemption
INSERT INTO movie (movie_id, title, release_date, director) VALUES (33, 'The Shawshank Redemption', '1994-09-23', 'Frank Darabont');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 33, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 33, person_id, 'Director' FROM person WHERE person_name = 'Frank Darabont';
INSERT INTO role (movie_id, person_id, role_type) SELECT 33, person_id, 'Actor' FROM person WHERE person_name = 'Tim Robbins';
INSERT INTO role (movie_id, person_id, role_type) SELECT 33, person_id, 'Actor' FROM person WHERE person_name = 'Morgan Freeman';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 33, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (10, 33, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (9, 33, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (9, 33, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (10, 33, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (9, 33, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (8, 33, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (9, 33, (SELECT user_id FROM "user" WHERE username = 'dana_w'));

-- 34. Titanic
INSERT INTO movie (movie_id, title, release_date, director) VALUES (34, 'Titanic', '1997-12-19', 'James Cameron');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 34, genre_id FROM genre WHERE name = 'Romance';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 34, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO role (movie_id, person_id, role_type) SELECT 34, person_id, 'Director' FROM person WHERE person_name = 'James Cameron';
INSERT INTO role (movie_id, person_id, role_type) SELECT 34, person_id, 'Actor' FROM person WHERE person_name = 'Leonardo DiCaprio';
INSERT INTO role (movie_id, person_id, role_type) SELECT 34, person_id, 'Actor' FROM person WHERE person_name = 'Kate Winslet';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 34, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (7, 34, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (8, 34, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (8, 34, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 34, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 34, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (7, 34, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (7, 34, (SELECT user_id FROM "user" WHERE username = 'dana_w'));

-- 35. Avatar
INSERT INTO movie (movie_id, title, release_date, director) VALUES (35, 'Avatar', '2009-12-18', 'James Cameron');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 35, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 35, genre_id FROM genre WHERE name = 'Adventure';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 35, genre_id FROM genre WHERE name = 'Action';
INSERT INTO role (movie_id, person_id, role_type) SELECT 35, person_id, 'Director' FROM person WHERE person_name = 'James Cameron';
INSERT INTO role (movie_id, person_id, role_type) SELECT 35, person_id, 'Actor' FROM person WHERE person_name = 'Sam Worthington';
INSERT INTO role (movie_id, person_id, role_type) SELECT 35, person_id, 'Actor' FROM person WHERE person_name = 'Zoe Saldaña';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (7, 35, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 35, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (8, 35, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (9, 35, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (8, 35, (SELECT user_id FROM "user" WHERE username = 'alex_m'));

-- 36. Barbie
INSERT INTO movie (movie_id, title, release_date, director) VALUES (36, 'Barbie', '2023-07-21', 'Greta Gerwig');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 36, genre_id FROM genre WHERE name = 'Comedy';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 36, genre_id FROM genre WHERE name = 'Fantasy';
INSERT INTO role (movie_id, person_id, role_type) SELECT 36, person_id, 'Director' FROM person WHERE person_name = 'Greta Gerwig';
INSERT INTO role (movie_id, person_id, role_type) SELECT 36, person_id, 'Actor' FROM person WHERE person_name = 'Margot Robbie';
INSERT INTO role (movie_id, person_id, role_type) SELECT 36, person_id, 'Actor' FROM person WHERE person_name = 'Ryan Gosling';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (6, 36, (SELECT user_id FROM "user" WHERE username = 'sam_r')),
  (6, 36, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (7, 36, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (7, 36, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (6, 36, (SELECT user_id FROM "user" WHERE username = 'preetham'));

-- 37. Little Women
INSERT INTO movie (movie_id, title, release_date, director) VALUES (37, 'Little Women', '2019-12-25', 'Greta Gerwig');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 37, genre_id FROM genre WHERE name = 'Drama';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 37, genre_id FROM genre WHERE name = 'Romance';
INSERT INTO role (movie_id, person_id, role_type) SELECT 37, person_id, 'Director' FROM person WHERE person_name = 'Greta Gerwig';
INSERT INTO role (movie_id, person_id, role_type) SELECT 37, person_id, 'Actor' FROM person WHERE person_name = 'Saoirse Ronan';
INSERT INTO role (movie_id, person_id, role_type) SELECT 37, person_id, 'Actor' FROM person WHERE person_name = 'Florence Pugh';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (6, 37, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (7, 37, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 37, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (9, 37, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (7, 37, (SELECT user_id FROM "user" WHERE username = 'kevin')),
  (9, 37, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (7, 37, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 37, (SELECT user_id FROM "user" WHERE username = 'preetham'));

-- 38. A Quiet Place
INSERT INTO movie (movie_id, title, release_date, director) VALUES (38, 'A Quiet Place', '2018-04-06', 'John Krasinski');
INSERT INTO movie_genre (movie_id, genre_id) SELECT 38, genre_id FROM genre WHERE name = 'Horror';
INSERT INTO movie_genre (movie_id, genre_id) SELECT 38, genre_id FROM genre WHERE name = 'Sci-Fi';
INSERT INTO role (movie_id, person_id, role_type) SELECT 38, person_id, 'Director' FROM person WHERE person_name = 'John Krasinski';
INSERT INTO role (movie_id, person_id, role_type) SELECT 38, person_id, 'Actor' FROM person WHERE person_name = 'Emily Blunt';
INSERT INTO role (movie_id, person_id, role_type) SELECT 38, person_id, 'Actor' FROM person WHERE person_name = 'John Krasinski';
INSERT INTO rating (rating_value, movie_id, user_id) VALUES
  (8, 38, (SELECT user_id FROM "user" WHERE username = 'taylor_b')),
  (7, 38, (SELECT user_id FROM "user" WHERE username = 'preetham')),
  (6, 38, (SELECT user_id FROM "user" WHERE username = 'jordan_k')),
  (8, 38, (SELECT user_id FROM "user" WHERE username = 'brianna')),
  (8, 38, (SELECT user_id FROM "user" WHERE username = 'chris_p')),
  (7, 38, (SELECT user_id FROM "user" WHERE username = 'alex_m')),
  (6, 38, (SELECT user_id FROM "user" WHERE username = 'dana_w')),
  (8, 38, (SELECT user_id FROM "user" WHERE username = 'meghana')),
  (8, 38, (SELECT user_id FROM "user" WHERE username = 'kevin'));

