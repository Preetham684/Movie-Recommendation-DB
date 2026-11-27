--
-- PostgreSQL database dump
--

\restrict 185UbmCXQDn4k9pMbl94jgbfjQn57swqQRAigXAoHKR11dgVsArSJAv6427zDot

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-26 21:33:21

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 17204)
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    genre_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17203)
-- Name: genre_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genre_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genre_genre_id_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 222
-- Name: genre_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genre_genre_id_seq OWNED BY public.genre.genre_id;


--
-- TOC entry 221 (class 1259 OID 17194)
-- Name: movie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie (
    movie_id integer NOT NULL,
    title character varying(200) NOT NULL,
    release_date date NOT NULL,
    director character varying(100) NOT NULL
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17226)
-- Name: movie_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_genre (
    movie_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE public.movie_genre OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17215)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    person_id integer NOT NULL,
    person_name character varying(100) NOT NULL,
    dob date NOT NULL
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17214)
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_person_id_seq OWNER TO postgres;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 224
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_person_id_seq OWNED BY public.person.person_id;


--
-- TOC entry 228 (class 1259 OID 17244)
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating (
    rating_id integer NOT NULL,
    rating_value smallint NOT NULL,
    movie_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT rating_rating_value_check CHECK (((rating_value >= 1) AND (rating_value <= 10)))
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17243)
-- Name: rating_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rating_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rating_rating_id_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 227
-- Name: rating_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rating_rating_id_seq OWNED BY public.rating.rating_id;


--
-- TOC entry 230 (class 1259 OID 17268)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    movie_id integer NOT NULL,
    person_id integer NOT NULL,
    role_type character varying(20) NOT NULL,
    CONSTRAINT role_role_type_check CHECK (((role_type)::text = ANY ((ARRAY['Actor'::character varying, 'Director'::character varying])::text[])))
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17267)
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_role_id_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 229
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;


--
-- TOC entry 220 (class 1259 OID 17180)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17179)
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_user_id_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 219
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;


--
-- TOC entry 4885 (class 2604 OID 17207)
-- Name: genre genre_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN genre_id SET DEFAULT nextval('public.genre_genre_id_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 17218)
-- Name: person person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN person_id SET DEFAULT nextval('public.person_person_id_seq'::regclass);


--
-- TOC entry 4887 (class 2604 OID 17247)
-- Name: rating rating_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating ALTER COLUMN rating_id SET DEFAULT nextval('public.rating_rating_id_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 17271)
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- TOC entry 4884 (class 2604 OID 17183)
-- Name: user user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);


--
-- TOC entry 5074 (class 0 OID 17204)
-- Dependencies: 223
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (genre_id, name) FROM stdin;
1	Action
2	Adventure
3	Sci-Fi
4	Mystery
5	Horror
6	Thriller
7	Animation
8	Comedy
9	Family
10	Fantasy
11	Drama
12	Music
13	Biography
14	Romance
15	History
16	Crime
17	Western
\.


--
-- TOC entry 5072 (class 0 OID 17194)
-- Dependencies: 221
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie (movie_id, title, release_date, director) FROM stdin;
1	Guardians of the Galaxy	2014-01-01	James Gunn
2	Prometheus	2012-01-01	Ridley Scott
3	Split	2016-01-01	M. Night Shyamalan
4	Sing	2016-01-01	Christophe Lourdelet
5	Suicide Squad	2016-01-01	David Ayer
6	The Great Wall	2016-01-01	Yimou Zhang
7	La La Land	2016-01-01	Damien Chazelle
8	Mindhorn	2016-01-01	Sean Foley
9	The Lost City of Z	2016-01-01	James Gray
10	Passengers	2016-01-01	Morten Tyldum
11	Fantastic Beasts and Where to Find Them	2016-01-01	David Yates
12	Hidden Figures	2016-01-01	Theodore Melfi
13	Rogue One	2016-01-01	Gareth Edwards
14	Moana	2016-01-01	Ron Clements
15	Colossal	2016-01-01	Nacho Vigalondo
16	The Secret Life of Pets	2016-01-01	Chris Renaud
17	Hacksaw Ridge	2016-01-01	Mel Gibson
18	Jason Bourne	2016-01-01	Paul Greengrass
19	Lion	2016-01-01	Garth Davis
20	Arrival	2016-01-01	Denis Villeneuve
21	Gold	2016-01-01	Stephen Gaghan
22	Manchester by the Sea	2016-01-01	Kenneth Lonergan
23	Hounds of Love	2016-01-01	Ben Young
24	Trolls	2016-01-01	Walt Dohrn
25	Independence Day: Resurgence	2016-01-01	Roland Emmerich
26	Paris pieds nus	2016-01-01	Dominique Abel
27	Bahubali: The Beginning	2015-01-01	S.S. Rajamouli
28	Dead Awake	2016-01-01	Phillip Guzman
29	Bad Moms	2016-01-01	Jon Lucas
30	Assassin's Creed	2016-01-01	Justin Kurzel
31	Why Him?	2016-01-01	John Hamburg
32	Nocturnal Animals	2016-01-01	Tom Ford
33	X-Men: Apocalypse	2016-01-01	Bryan Singer
34	Deadpool	2016-01-01	Tim Miller
35	Resident Evil: The Final Chapter	2016-01-01	Paul W.S. Anderson
36	Captain America: Civil War	2016-01-01	Anthony Russo
37	Interstellar	2014-01-01	Christopher Nolan
38	Doctor Strange	2016-01-01	Scott Derrickson
39	The Magnificent Seven	2016-01-01	Antoine Fuqua
40	5- 25- 77	2007-01-01	Patrick Read Johnson
41	Sausage Party	2016-01-01	Greg Tiernan
42	Moonlight	2016-01-01	Barry Jenkins
43	Don't Fuck in the Woods	2016-01-01	Shawn Burkett
44	The Founder	2016-01-01	John Lee Hancock
45	Lowriders	2016-01-01	Ricardo de Montreuil
46	Pirates of the Caribbean: On Stranger Tides	2011-01-01	Rob Marshall
47	Miss Sloane	2016-01-01	John Madden
48	Fallen	2016-01-01	Scott Hicks
49	Star Trek Beyond	2016-01-01	Justin Lin
50	The Last Face	2016-01-01	Sean Penn
\.


--
-- TOC entry 5077 (class 0 OID 17226)
-- Dependencies: 226
-- Data for Name: movie_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_genre (movie_id, genre_id) FROM stdin;
49	1
46	1
39	1
38	1
36	1
35	1
34	1
33	1
30	1
27	1
25	1
18	1
15	1
13	1
9	1
6	1
5	1
1	1
49	2
48	2
46	2
41	2
39	2
38	2
37	2
36	2
34	2
33	2
30	2
27	2
25	2
24	2
21	2
16	2
14	2
13	2
11	2
10	2
9	2
6	2
5	2
2	2
1	2
49	3
37	3
36	3
35	3
33	3
25	3
20	3
13	3
2	3
1	3
20	4
2	4
43	5
35	5
28	5
23	5
3	5
47	6
32	6
28	6
21	6
18	6
3	6
41	7
24	7
16	7
14	7
4	7
41	8
40	8
34	8
31	8
29	8
26	8
24	8
16	8
15	8
14	8
8	8
7	8
4	8
11	9
4	9
48	10
46	10
38	10
11	10
6	10
5	10
50	11
48	11
47	11
45	11
44	11
42	11
40	11
37	11
32	11
30	11
27	11
23	11
22	11
21	11
20	11
19	11
17	11
15	11
12	11
10	11
7	11
7	12
44	13
19	13
17	13
12	13
9	13
10	14
44	15
17	15
12	15
23	16
39	17
\.


--
-- TOC entry 5076 (class 0 OID 17215)
-- Dependencies: 225
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (person_id, person_name, dob) FROM stdin;
1	James Gunn	1950-01-01
2	Ridley Scott	1950-02-07
3	M. Night Shyamalan	1950-03-16
4	Christophe Lourdelet	1950-04-22
5	David Ayer	1950-05-29
6	Yimou Zhang	1950-07-05
7	Damien Chazelle	1950-08-11
8	Sean Foley	1950-09-17
9	James Gray	1950-10-24
10	Morten Tyldum	1950-11-30
11	David Yates	1951-01-06
12	Theodore Melfi	1951-02-12
13	Gareth Edwards	1951-03-21
14	Ron Clements	1951-04-27
15	Nacho Vigalondo	1951-06-03
16	Chris Renaud	1951-07-10
17	Mel Gibson	1951-08-16
18	Paul Greengrass	1951-09-22
19	Garth Davis	1951-10-29
20	Denis Villeneuve	1951-12-05
21	Stephen Gaghan	1952-01-11
22	Kenneth Lonergan	1952-02-17
23	Ben Young	1952-03-25
24	Walt Dohrn	1952-05-01
25	Roland Emmerich	1952-06-07
26	Dominique Abel	1952-07-14
27	S.S. Rajamouli	1952-08-20
28	Phillip Guzman	1952-09-26
29	Jon Lucas	1952-11-02
30	Justin Kurzel	1952-12-09
31	John Hamburg	1953-01-15
32	Tom Ford	1953-02-21
33	Bryan Singer	1953-03-30
34	Tim Miller	1953-05-06
35	Paul W.S. Anderson	1953-06-12
36	Anthony Russo	1953-07-19
37	Christopher Nolan	1953-08-25
38	Scott Derrickson	1953-10-01
39	Antoine Fuqua	1953-11-07
40	Patrick Read Johnson	1953-12-14
41	Greg Tiernan	1954-01-20
42	Barry Jenkins	1954-02-26
43	Shawn Burkett	1954-04-04
44	John Lee Hancock	1954-05-11
45	Ricardo de Montreuil	1954-06-17
46	Rob Marshall	1954-07-24
47	John Madden	1954-08-30
48	Scott Hicks	1954-10-06
49	Justin Lin	1954-11-12
50	Sean Penn	1954-12-19
51	Chris Pratt	1955-01-25
52	Vin Diesel	1955-03-03
53	Bradley Cooper	1955-04-09
54	Zoe Saldana	1955-05-16
55	Noomi Rapace	1955-06-22
56	Logan Marshall-Green	1955-07-29
57	Michael Fassbender	1955-09-04
58	Charlize Theron	1955-10-11
59	James McAvoy	1955-11-17
60	Anya Taylor-Joy	1955-12-24
61	Haley Lu Richardson	1956-01-30
62	Jessica Sula	1956-03-07
63	Matthew McConaughey	1956-04-13
64	Reese Witherspoon	1956-05-20
65	Seth MacFarlane	1956-06-26
66	Scarlett Johansson	1956-08-02
67	Will Smith	1956-09-08
68	Jared Leto	1956-10-15
69	Margot Robbie	1956-11-21
70	Viola Davis	1956-12-28
71	Matt Damon	1957-02-03
72	Tian Jing	1957-03-12
73	Willem Dafoe	1957-04-18
74	Andy Lau	1957-05-25
75	Ryan Gosling	1957-07-01
76	Emma Stone	1957-08-07
77	Rosemarie DeWitt	1957-09-13
78	J.K. Simmons	1957-10-20
79	Essie Davis	1957-11-26
80	Andrea Riseborough	1958-01-02
81	Julian Barratt	1958-02-08
82	Kenneth Branagh	1958-03-17
83	Charlie Hunnam	1958-04-23
84	Robert Pattinson	1958-05-30
85	Sienna Miller	1958-07-06
86	Tom Holland	1958-08-12
87	Jennifer Lawrence	1958-09-18
88	Michael Sheen	1958-10-25
89	Laurence Fishburne	1958-12-01
90	Eddie Redmayne	1959-01-07
91	Katherine Waterston	1959-02-13
92	Alison Sudol	1959-03-22
93	Dan Fogler	1959-04-28
94	Taraji P. Henson	1959-06-04
95	Octavia Spencer	1959-07-11
96	Janelle Monáe	1959-08-17
97	Kevin Costner	1959-09-23
98	Felicity Jones	1959-10-30
99	Diego Luna	1959-12-06
100	Alan Tudyk	1960-01-12
101	Donnie Yen	1960-02-18
102	Auli'i Cravalho	1960-03-26
103	Dwayne Johnson	1960-05-02
104	Rachel House	1960-06-08
105	Temuera Morrison	1960-07-15
106	Anne Hathaway	1960-08-21
107	Jason Sudeikis	1960-09-27
108	Austin Stowell	1960-11-03
109	Tim Blake Nelson	1960-12-10
110	Louis C.K.	1961-01-16
111	Eric Stonestreet	1961-02-22
112	Kevin Hart	1961-03-31
113	Lake Bell	1961-05-07
114	Andrew Garfield	1961-06-13
115	Sam Worthington	1961-07-20
116	Luke Bracey	1961-08-26
117	Teresa Palmer	1961-10-02
118	Tommy Lee Jones	1961-11-08
119	Alicia Vikander	1961-12-15
120	Vincent Cassel	1962-01-21
121	Dev Patel	1962-02-27
122	Nicole Kidman	1962-04-05
123	Rooney Mara	1962-05-12
124	Sunny Pawar	1962-06-18
125	Amy Adams	1962-07-25
126	Jeremy Renner	1962-08-31
127	Forest Whitaker	1962-10-07
128	Michael Stuhlbarg	1962-11-13
129	Edgar Ramírez	1962-12-20
130	Bryce Dallas Howard	1963-01-26
131	Corey Stoll	1963-03-04
132	Casey Affleck	1963-04-10
133	Michelle Williams	1963-05-17
134	Kyle Chandler	1963-06-23
135	Lucas Hedges	1963-07-30
136	Emma Booth	1963-09-05
137	Ashleigh Cummings	1963-10-12
138	Stephen Curry	1963-11-18
139	Susie Porter	1963-12-25
140	Anna Kendrick	1964-01-31
141	Justin Timberlake	1964-03-08
142	Zooey Deschanel	1964-04-14
143	Christopher Mintz-Plasse	1964-05-21
144	Liam Hemsworth	1964-06-27
145	Jeff Goldblum	1964-08-03
146	Bill Pullman	1964-09-09
147	Maika Monroe	1964-10-16
148	Fiona Gordon	1964-11-22
149	Emmanuelle Riva	1964-12-29
150	Pierre Richard	1965-02-04
151	Prabhas	1965-03-13
152	Rana Daggubati	1965-04-19
153	Anushka Shetty	1965-05-26
154	Tamannaah Bhatia	1965-07-02
155	Jocelin Donahue	1965-08-08
156	Jesse Bradford	1965-09-14
157	Jesse Borrego	1965-10-21
158	Lori Petty	1965-11-27
159	Mila Kunis	1966-01-03
160	Kathryn Hahn	1966-02-09
161	Kristen Bell	1966-03-18
162	Christina Applegate	1966-04-24
163	Marion Cotillard	1966-05-31
164	Jeremy Irons	1966-07-07
165	Brendan Gleeson	1966-08-13
166	Zoey Deutch	1966-09-19
167	James Franco	1966-10-26
168	Tangie Ambrose	1966-12-02
169	Cedric the Entertainer	1967-01-08
170	Jake Gyllenhaal	1967-02-14
171	Michael Shannon	1967-03-23
172	Aaron Taylor-Johnson	1967-04-29
173	Nicholas Hoult	1967-06-05
174	Ryan Reynolds	1967-07-12
175	Morena Baccarin	1967-08-18
176	T.J. Miller	1967-09-24
177	Ed Skrein	1967-10-31
178	Milla Jovovich	1967-12-07
179	Iain Glen	1968-01-13
180	Ali Larter	1968-02-19
181	Shawn Roberts	1968-03-27
182	Chris Evans	1968-05-03
183	Robert Downey Jr.	1968-06-09
184	Sebastian Stan	1968-07-16
185	Jessica Chastain	1968-08-22
186	Mackenzie Foy	1968-09-28
187	Benedict Cumberbatch	1968-11-04
188	Chiwetel Ejiofor	1968-12-11
189	Rachel McAdams	1969-01-17
190	Benedict Wong	1969-02-23
191	Denzel Washington	1969-04-01
192	Ethan Hawke	1969-05-08
193	Vincent D'Onofrio	1969-06-14
194	John Francis Daley	1969-07-21
195	Austin Pendleton	1969-08-27
196	Colleen Camp	1969-10-03
197	Neil Flynn	1969-11-09
198	Seth Rogen	1969-12-16
199	Kristen Wiig	1970-01-22
200	Jonah Hill	1970-02-28
201	Alistair Abell	1970-04-06
202	Mahershala Ali	1970-05-13
203	Shariff Earp	1970-06-19
204	Duan Sanderson	1970-07-26
205	Alex R. Hibbert	1970-09-01
206	Brittany Blanton	1970-10-08
207	Ayse Howard	1970-11-14
208	Roman Jossart	1970-12-21
209	Nadia White	1971-01-27
210	Michael Keaton	1971-03-05
211	Nick Offerman	1971-04-11
212	John Carroll Lynch	1971-05-18
213	Linda Cardellini	1971-06-24
214	Gabriel Chavarria	1971-07-31
215	Demián Bichir	1971-09-06
216	Theo Rossi	1971-10-13
217	Tony Revolori	1971-11-19
218	Johnny Depp	1971-12-26
219	Penélope Cruz	1972-02-01
220	Ian McShane	1972-03-09
221	Geoffrey Rush	1972-04-15
222	Mark Strong	1972-05-22
223	Gugu Mbatha-Raw	1972-06-28
224	Hermione Corfield	1972-08-04
225	Addison Timlin	1972-09-10
226	Joely Richardson	1972-10-17
227	Jeremy Irvine	1972-11-23
228	Chris Pine	1972-12-30
229	Zachary Quinto	1973-02-05
230	Karl Urban	1973-03-14
231	Javier Bardem	1973-04-20
232	Adèle Exarchopoulos	1973-05-27
233	Jared Harris	1973-07-03
\.


--
-- TOC entry 5079 (class 0 OID 17244)
-- Dependencies: 228
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rating (rating_id, rating_value, movie_id, user_id) FROM stdin;
1	7	3	1
2	5	3	5
3	4	4	2
4	6	4	5
5	8	5	2
6	4	5	5
7	4	6	5
8	3	7	3
9	6	9	3
10	10	15	5
11	9	21	2
12	8	26	1
13	10	27	2
14	10	28	1
15	8	28	4
16	7	33	2
17	6	35	1
18	5	37	1
19	6	38	1
20	4	38	4
\.


--
-- TOC entry 5081 (class 0 OID 17268)
-- Dependencies: 230
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (role_id, movie_id, person_id, role_type) FROM stdin;
1	1	1	Director
2	1	51	Actor
3	1	52	Actor
4	1	53	Actor
5	1	54	Actor
6	2	2	Director
7	2	55	Actor
8	2	56	Actor
9	2	57	Actor
10	2	58	Actor
11	3	3	Director
12	3	59	Actor
13	3	60	Actor
14	3	61	Actor
15	3	62	Actor
16	4	4	Director
17	4	63	Actor
18	4	64	Actor
19	4	65	Actor
20	4	66	Actor
21	5	5	Director
22	5	67	Actor
23	5	68	Actor
24	5	69	Actor
25	5	70	Actor
26	6	6	Director
27	6	71	Actor
28	6	72	Actor
29	6	73	Actor
30	6	74	Actor
31	7	7	Director
32	7	75	Actor
33	7	76	Actor
34	7	77	Actor
35	7	78	Actor
36	8	8	Director
37	8	79	Actor
38	8	80	Actor
39	8	81	Actor
40	8	82	Actor
41	9	9	Director
42	9	83	Actor
43	9	84	Actor
44	9	85	Actor
45	9	86	Actor
46	10	10	Director
47	10	87	Actor
48	10	51	Actor
49	10	88	Actor
50	10	89	Actor
51	11	11	Director
52	11	90	Actor
53	11	91	Actor
54	11	92	Actor
55	11	93	Actor
56	12	12	Director
57	12	94	Actor
58	12	95	Actor
59	12	96	Actor
60	12	97	Actor
61	13	13	Director
62	13	98	Actor
63	13	99	Actor
64	13	100	Actor
65	13	101	Actor
66	14	14	Director
67	14	102	Actor
68	14	103	Actor
69	14	104	Actor
70	14	105	Actor
71	15	15	Director
72	15	106	Actor
73	15	107	Actor
74	15	108	Actor
75	15	109	Actor
76	16	16	Director
77	16	110	Actor
78	16	111	Actor
79	16	112	Actor
80	16	113	Actor
81	17	17	Director
82	17	114	Actor
83	17	115	Actor
84	17	116	Actor
85	17	117	Actor
86	18	18	Director
87	18	71	Actor
88	18	118	Actor
89	18	119	Actor
90	18	120	Actor
91	19	19	Director
92	19	121	Actor
93	19	122	Actor
94	19	123	Actor
95	19	124	Actor
96	20	20	Director
97	20	125	Actor
98	20	126	Actor
99	20	127	Actor
100	20	128	Actor
101	21	21	Director
102	21	63	Actor
103	21	129	Actor
104	21	130	Actor
105	21	131	Actor
106	22	22	Director
107	22	132	Actor
108	22	133	Actor
109	22	134	Actor
110	22	135	Actor
111	23	23	Director
112	23	136	Actor
113	23	137	Actor
114	23	138	Actor
115	23	139	Actor
116	24	24	Director
117	24	140	Actor
118	24	141	Actor
119	24	142	Actor
120	24	143	Actor
121	25	25	Director
122	25	144	Actor
123	25	145	Actor
124	25	146	Actor
125	25	147	Actor
126	26	26	Director
127	26	148	Actor
128	26	26	Actor
129	26	149	Actor
130	26	150	Actor
131	27	27	Director
132	27	151	Actor
133	27	152	Actor
134	27	153	Actor
135	27	154	Actor
136	28	28	Director
137	28	155	Actor
138	28	156	Actor
139	28	157	Actor
140	28	158	Actor
141	29	29	Director
142	29	159	Actor
143	29	160	Actor
144	29	161	Actor
145	29	162	Actor
146	30	30	Director
147	30	57	Actor
148	30	163	Actor
149	30	164	Actor
150	30	165	Actor
151	31	31	Director
152	31	166	Actor
153	31	167	Actor
154	31	168	Actor
155	31	169	Actor
156	32	32	Director
157	32	125	Actor
158	32	170	Actor
159	32	171	Actor
160	32	172	Actor
161	33	33	Director
162	33	59	Actor
163	33	57	Actor
164	33	87	Actor
165	33	173	Actor
166	34	34	Director
167	34	174	Actor
168	34	175	Actor
169	34	176	Actor
170	34	177	Actor
171	35	35	Director
172	35	178	Actor
173	35	179	Actor
174	35	180	Actor
175	35	181	Actor
176	36	36	Director
177	36	182	Actor
178	36	183	Actor
179	36	66	Actor
180	36	184	Actor
181	37	37	Director
182	37	63	Actor
183	37	106	Actor
184	37	185	Actor
185	37	186	Actor
186	38	38	Director
187	38	187	Actor
188	38	188	Actor
189	38	189	Actor
190	38	190	Actor
191	39	39	Director
192	39	191	Actor
193	39	51	Actor
194	39	192	Actor
195	39	193	Actor
196	40	40	Director
197	40	194	Actor
198	40	195	Actor
199	40	196	Actor
200	40	197	Actor
201	41	41	Director
202	41	198	Actor
203	41	199	Actor
204	41	200	Actor
205	41	201	Actor
206	42	42	Director
207	42	202	Actor
208	42	203	Actor
209	42	204	Actor
210	42	205	Actor
211	43	43	Director
212	43	206	Actor
213	43	207	Actor
214	43	208	Actor
215	43	209	Actor
216	44	44	Director
217	44	210	Actor
218	44	211	Actor
219	44	212	Actor
220	44	213	Actor
221	45	45	Director
222	45	214	Actor
223	45	215	Actor
224	45	216	Actor
225	45	217	Actor
226	46	46	Director
227	46	218	Actor
228	46	219	Actor
229	46	220	Actor
230	46	221	Actor
231	47	47	Director
232	47	185	Actor
233	47	222	Actor
234	47	223	Actor
235	47	128	Actor
236	48	48	Director
237	48	224	Actor
238	48	225	Actor
239	48	226	Actor
240	48	227	Actor
241	49	49	Director
242	49	228	Actor
243	49	229	Actor
244	49	230	Actor
245	49	54	Actor
246	50	50	Director
247	50	58	Actor
248	50	231	Actor
249	50	232	Actor
250	50	233	Actor
\.


--
-- TOC entry 5071 (class 0 OID 17180)
-- Dependencies: 220
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (user_id, username, email, password) FROM stdin;
2	Person2	person2@gmail.com	80e9d0efe2d4f822c2ca5539dc8065b0cac985998e10929324221d8223d97db7
3	Person3	person3@gmail.com	b76ce2ffc0785ede20aa06117c5fa4edd952fa1c6ac25501b8358fba56a7e7bf
4	Person4	person4@gmail.com	bee534a6aa70fabeadd5a62e67b54f89cc0de20e80348ddb2bc5694a64d940c8
5	Person5	person5@gmail.com	fbd0298f0275a08befee40d2f6797be868b155976a34e55840d00828ddd17e24
1	Person1	new_email_address@gmail.com	9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c
\.


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 222
-- Name: genre_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_genre_id_seq', 17, true);


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 224
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_person_id_seq', 233, true);


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 227
-- Name: rating_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rating_rating_id_seq', 22, true);


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 229
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_role_id_seq', 250, true);


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 219
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_user_id_seq', 5, true);


--
-- TOC entry 4900 (class 2606 OID 17213)
-- Name: genre genre_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_name_key UNIQUE (name);


--
-- TOC entry 4902 (class 2606 OID 17211)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (genre_id);


--
-- TOC entry 4908 (class 2606 OID 17232)
-- Name: movie_genre movie_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT movie_genre_pkey PRIMARY KEY (movie_id, genre_id);


--
-- TOC entry 4898 (class 2606 OID 17202)
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (movie_id);


--
-- TOC entry 4904 (class 2606 OID 17225)
-- Name: person person_person_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_person_name_key UNIQUE (person_name);


--
-- TOC entry 4906 (class 2606 OID 17223)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- TOC entry 4910 (class 2606 OID 17256)
-- Name: rating rating_movie_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_movie_id_user_id_key UNIQUE (movie_id, user_id);


--
-- TOC entry 4912 (class 2606 OID 17254)
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (rating_id);


--
-- TOC entry 4914 (class 2606 OID 17280)
-- Name: role role_movie_id_person_id_role_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_movie_id_person_id_role_type_key UNIQUE (movie_id, person_id, role_type);


--
-- TOC entry 4916 (class 2606 OID 17278)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 4892 (class 2606 OID 17193)
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 4894 (class 2606 OID 17189)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4896 (class 2606 OID 17191)
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- TOC entry 4917 (class 2606 OID 17238)
-- Name: movie_genre movie_genre_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT movie_genre_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genre(genre_id) ON DELETE CASCADE;


--
-- TOC entry 4918 (class 2606 OID 17233)
-- Name: movie_genre movie_genre_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT movie_genre_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(movie_id) ON DELETE CASCADE;


--
-- TOC entry 4919 (class 2606 OID 17257)
-- Name: rating rating_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(movie_id) ON DELETE CASCADE;


--
-- TOC entry 4920 (class 2606 OID 17262)
-- Name: rating rating_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id) ON DELETE CASCADE;


--
-- TOC entry 4921 (class 2606 OID 17281)
-- Name: role role_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(movie_id) ON DELETE CASCADE;


--
-- TOC entry 4922 (class 2606 OID 17286)
-- Name: role role_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON DELETE CASCADE;


-- Completed on 2026-11-26 21:33:22

--
-- PostgreSQL database dump complete
--

\unrestrict 185UbmCXQDn4k9pMbl94jgbfjQn57swqQRAigXAoHKR11dgVsArSJAv6427zDot

