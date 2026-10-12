--
-- PostgreSQL database dump
--

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-12 14:37:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16827)
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    genreid integer CONSTRAINT "Genre_genreId_not_null" NOT NULL,
    name name CONSTRAINT "Genre_name_not_null" NOT NULL
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16826)
-- Name: Genre_genreId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Genre_genreId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Genre_genreId_seq" OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 223
-- Name: Genre_genreId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Genre_genreId_seq" OWNED BY public.genre.genreid;


--
-- TOC entry 233 (class 1259 OID 16914)
-- Name: movie_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_genre (
    movieid integer CONSTRAINT "Has_movieid_not_null" NOT NULL,
    genreid integer CONSTRAINT "Has_genreid_not_null" NOT NULL
);


ALTER TABLE public.movie_genre OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE movie_genre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.movie_genre IS '"has" relationship';


--
-- TOC entry 232 (class 1259 OID 16913)
-- Name: Has_genreid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Has_genreid_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Has_genreid_seq" OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 232
-- Name: Has_genreid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Has_genreid_seq" OWNED BY public.movie_genre.genreid;


--
-- TOC entry 231 (class 1259 OID 16912)
-- Name: Has_movieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Has_movieid_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Has_movieid_seq" OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 231
-- Name: Has_movieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Has_movieid_seq" OWNED BY public.movie_genre.movieid;


--
-- TOC entry 220 (class 1259 OID 16804)
-- Name: movie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie (
    movieid integer CONSTRAINT "Movie_movieId_not_null" NOT NULL,
    title name CONSTRAINT "Movie_title_not_null" NOT NULL,
    release_date date CONSTRAINT "Movie_release_date_not_null" NOT NULL,
    director name CONSTRAINT "Movie_director_not_null" NOT NULL
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16803)
-- Name: Movie_movieId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Movie_movieId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Movie_movieId_seq" OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 219
-- Name: Movie_movieId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Movie_movieId_seq" OWNED BY public.movie.movieid;


--
-- TOC entry 226 (class 1259 OID 16836)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    personid integer CONSTRAINT "Person_personId_not_null" NOT NULL,
    person_name name CONSTRAINT "Person_personName_not_null" NOT NULL,
    dob date CONSTRAINT "Person_dob_not_null" NOT NULL
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16835)
-- Name: Person_personId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Person_personId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Person_personId_seq" OWNER TO postgres;

--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 225
-- Name: Person_personId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Person_personId_seq" OWNED BY public.person.personid;


--
-- TOC entry 228 (class 1259 OID 16845)
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating (
    ratingid integer CONSTRAINT "Rating_ratingId_not_null" NOT NULL,
    rating_value integer CONSTRAINT "Rating_ratingValue_not_null" NOT NULL,
    movieid integer CONSTRAINT "Rating_movieId_not_null" NOT NULL,
    userid integer CONSTRAINT "Rating_userId_not_null" NOT NULL
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16844)
-- Name: Rating_ratingId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rating_ratingId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Rating_ratingId_seq" OWNER TO postgres;

--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 227
-- Name: Rating_ratingId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rating_ratingId_seq" OWNED BY public.rating.ratingid;


--
-- TOC entry 230 (class 1259 OID 16866)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    roleid integer CONSTRAINT "Role_roleId_not_null" NOT NULL,
    movieid integer CONSTRAINT "Role_movie_Id_not_null" NOT NULL,
    personid integer CONSTRAINT "Role_person_Id_not_null" NOT NULL,
    role_type name CONSTRAINT "Role_role_Type_not_null" NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16865)
-- Name: Role_roleId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Role_roleId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Role_roleId_seq" OWNER TO postgres;

--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 229
-- Name: Role_roleId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Role_roleId_seq" OWNED BY public.role.roleid;


--
-- TOC entry 222 (class 1259 OID 16816)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    userid integer CONSTRAINT "User_userId_not_null" NOT NULL,
    username name CONSTRAINT "User_username_not_null" NOT NULL,
    email name CONSTRAINT "User_email_not_null" NOT NULL,
    password name CONSTRAINT "User_password_not_null" NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16815)
-- Name: User_userId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_userId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_userId_seq" OWNER TO postgres;

--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 221
-- Name: User_userId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_userId_seq" OWNED BY public."user".userid;


--
-- TOC entry 4889 (class 2604 OID 16830)
-- Name: genre genreid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN genreid SET DEFAULT nextval('public."Genre_genreId_seq"'::regclass);


--
-- TOC entry 4887 (class 2604 OID 16807)
-- Name: movie movieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie ALTER COLUMN movieid SET DEFAULT nextval('public."Movie_movieId_seq"'::regclass);


--
-- TOC entry 4893 (class 2604 OID 16917)
-- Name: movie_genre movieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre ALTER COLUMN movieid SET DEFAULT nextval('public."Has_movieid_seq"'::regclass);


--
-- TOC entry 4894 (class 2604 OID 16918)
-- Name: movie_genre genreid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre ALTER COLUMN genreid SET DEFAULT nextval('public."Has_genreid_seq"'::regclass);


--
-- TOC entry 4890 (class 2604 OID 16839)
-- Name: person personid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN personid SET DEFAULT nextval('public."Person_personId_seq"'::regclass);


--
-- TOC entry 4891 (class 2604 OID 16848)
-- Name: rating ratingid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating ALTER COLUMN ratingid SET DEFAULT nextval('public."Rating_ratingId_seq"'::regclass);


--
-- TOC entry 4892 (class 2604 OID 16869)
-- Name: role roleid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN roleid SET DEFAULT nextval('public."Role_roleId_seq"'::regclass);


--
-- TOC entry 4888 (class 2604 OID 16819)
-- Name: user userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN userid SET DEFAULT nextval('public."User_userId_seq"'::regclass);


--
-- TOC entry 5077 (class 0 OID 16827)
-- Dependencies: 224
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (genreid, name) FROM stdin;
1	Action
2	Thriller
3	Horror
4	Romance
5	Comedy
6	Sci-Fi
7	Fantasy
8	Drama
9	Biography
10	Adventure
11	Animation
12	Mystery
13	Crime
14	Western
15	Family
\.


--
-- TOC entry 5073 (class 0 OID 16804)
-- Dependencies: 220
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie (movieid, title, release_date, director) FROM stdin;
6	Guardians of the Galaxy	2014-08-01	James Gunn
7	Prometheus	2012-06-01	Ridley Scott
8	Split	2017-01-20	M. Night Shyamalan
\.


--
-- TOC entry 5086 (class 0 OID 16914)
-- Dependencies: 233
-- Data for Name: movie_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_genre (movieid, genreid) FROM stdin;
6	1
6	10
6	6
7	10
7	12
7	6
8	3
8	2
\.


--
-- TOC entry 5079 (class 0 OID 16836)
-- Dependencies: 226
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (personid, person_name, dob) FROM stdin;
1	Chris Pratt	1979-06-21
2	Vin Diesel	1967-07-18
3	Bradley Cooper	1975-01-05
4	Zoe Saldana	1978-06-19
5	Noomi Rapace	1979-12-28
6	Logan Marshall-Green	1976-11-01
7	Michael Fassbender	1977-04-02
10	Charlize Theron	1975-03-07
11	James McAvoy	1979-04-21
\.


--
-- TOC entry 5081 (class 0 OID 16845)
-- Dependencies: 228
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rating (ratingid, rating_value, movieid, userid) FROM stdin;
1	6	7	3
2	10	8	4
3	4	6	5
5	8	8	3
\.


--
-- TOC entry 5083 (class 0 OID 16866)
-- Dependencies: 230
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (roleid, movieid, personid, role_type) FROM stdin;
6	6	1	Actor
7	6	11	Director
8	7	5	Actor
9	7	10	Actor
10	8	7	Actor
11	8	1	Director
\.


--
-- TOC entry 5075 (class 0 OID 16816)
-- Dependencies: 222
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (userid, username, email, password) FROM stdin;
2	Person1	person1@gmail.com	pass123
3	Person2	person2@gmail.com	secure456
4	Person3	person3@gmail.com	hello789
5	Person4	person4@gmail.com	apple321
\.


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 223
-- Name: Genre_genreId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Genre_genreId_seq"', 15, true);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 232
-- Name: Has_genreid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Has_genreid_seq"', 1, false);


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 231
-- Name: Has_movieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Has_movieid_seq"', 1, false);


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 219
-- Name: Movie_movieId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Movie_movieId_seq"', 8, true);


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 225
-- Name: Person_personId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Person_personId_seq"', 11, true);


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 227
-- Name: Rating_ratingId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rating_ratingId_seq"', 5, true);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 229
-- Name: Role_roleId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Role_roleId_seq"', 11, true);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 221
-- Name: User_userId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_userId_seq"', 5, true);


--
-- TOC entry 4906 (class 2606 OID 16834)
-- Name: genre Genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT "Genre_pkey" PRIMARY KEY (genreid);


--
-- TOC entry 4896 (class 2606 OID 16814)
-- Name: movie Movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT "Movie_pkey" PRIMARY KEY (movieid);


--
-- TOC entry 4910 (class 2606 OID 16843)
-- Name: person Person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT "Person_pkey" PRIMARY KEY (personid);


--
-- TOC entry 4916 (class 2606 OID 16852)
-- Name: rating Rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT "Rating_pkey" PRIMARY KEY (ratingid);


--
-- TOC entry 4918 (class 2606 OID 16875)
-- Name: role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (roleid);


--
-- TOC entry 4898 (class 2606 OID 16825)
-- Name: user User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (userid);


--
-- TOC entry 4912 (class 2606 OID 16937)
-- Name: person dob; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT dob UNIQUE (dob) INCLUDE (dob);


--
-- TOC entry 4900 (class 2606 OID 16896)
-- Name: user email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT email UNIQUE (email) INCLUDE (email);


--
-- TOC entry 4908 (class 2606 OID 16892)
-- Name: genre name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT name UNIQUE (name) INCLUDE (name);


--
-- TOC entry 4902 (class 2606 OID 16898)
-- Name: user password; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT password UNIQUE (password) INCLUDE (password);


--
-- TOC entry 4914 (class 2606 OID 16935)
-- Name: person person_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_name UNIQUE (person_name) INCLUDE (person_name);


--
-- TOC entry 4904 (class 2606 OID 16894)
-- Name: user username; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT username UNIQUE (username) INCLUDE (username);


--
-- TOC entry 4923 (class 2606 OID 16926)
-- Name: movie_genre genreid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT genreid FOREIGN KEY (genreid) REFERENCES public.genre(genreid);


--
-- TOC entry 4919 (class 2606 OID 16855)
-- Name: rating movieId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT "movieId" FOREIGN KEY (movieid) REFERENCES public.movie(movieid) NOT VALID;


--
-- TOC entry 4924 (class 2606 OID 16921)
-- Name: movie_genre movieid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT movieid FOREIGN KEY (movieid) REFERENCES public.movie(movieid);


--
-- TOC entry 4921 (class 2606 OID 16881)
-- Name: role movieid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT movieid FOREIGN KEY (movieid) REFERENCES public.movie(movieid);


--
-- TOC entry 4922 (class 2606 OID 16886)
-- Name: role personid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT personid FOREIGN KEY (personid) REFERENCES public.person(personid);


--
-- TOC entry 4920 (class 2606 OID 16860)
-- Name: rating userId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT "userId" FOREIGN KEY (userid) REFERENCES public."user"(userid) NOT VALID;


--
-- PostgreSQL database dump complete
--