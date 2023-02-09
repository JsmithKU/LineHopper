--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: finalizedreports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE if not exists public.finalizedreports (
    reportid bigint NOT NULL,
    restaurantid bigint,
    cleanrank numeric,
    busyrank numeric,
    picture boolean,
    submissiontime timestamp with time zone
);


--
-- Name: location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE if not exists public.location (
    restaurantid bigint NOT NULL,
    address character varying,
    hoursopen character varying
);


--
-- Name: restaurant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE if not exists public.restaurant (
    restaurantid bigint NOT NULL,
    name character varying,
    cleanavg numeric,
    busyavg numeric
);


--
-- Name: uncheckedreports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE if not exists public.uncheckedreports (
    reportid bigint NOT NULL,
    restaurantid bigint,
    cleanrank numeric,
    busyrank numeric,
    picture boolean,
    submissiontime timestamp with time zone
);


--
-- Data for Name: finalizedreports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) FROM stdin;
100	1	1.0	1.0	f	2004-10-19 01:23:54-04
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.location (restaurantid, address, hoursopen) FROM stdin;
1	123 street A	1am-10pm
2	McFarland Student Building	7am-7pm
3	Schaeffer Ln	10:30am-2pm
4	South Dining Hall	\N
5	South Dining Hall	\N
6	South Dining Hall	7am-7pm
7	South Dining Hall	8pm-1am
\.


--
-- Data for Name: restaurant; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.restaurant (restaurantid, name, cleanavg, busyavg) FROM stdin;
1	Test Dining Hall	\N	\N
2	Cub Cafe	\N	\N
3	Forum Food Court	\N	\N
4	South Dining Hall	\N	\N
5	Avalanche	\N	\N
6	Sunnysides	\N	\N
7	Hearth Deli	\N	\N
\.


--
-- Data for Name: uncheckedreports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.uncheckedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) FROM stdin;
2	1	1.0	1.0	f	2022-11-20 05:00:00-05
3	1	1.0	1.0	f	2022-11-20 06:00:00-05
4	1	2.0	3.0	f	2022-11-20 10:00:00-05
5	2	1.0	1.0	f	2022-11-20 02:00:00-05
6	2	4.0	3.0	f	2022-11-20 04:00:00-05
1	1	1.0	1.0	f	2022-11-20 05:00:00-05
12	1	1.0	1.0	f	2022-11-19 05:00:00-05
11	2	4.0	3.0	f	2022-11-19 04:00:00-05
10	2	1.0	1.0	f	2022-11-19 02:00:00-05
9	1	2.0	3.0	f	2022-11-19 10:00:00-05
8	1	1.0	1.0	f	2022-11-19 06:00:00-05
7	1	1.0	1.0	f	2022-11-19 05:00:00-05
\.


--
-- Name: finalizedreports finalizedreports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finalizedreports
    ADD CONSTRAINT finalizedreports_pkey PRIMARY KEY (reportid);


--
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (restaurantid);


--
-- Name: restaurant restaurant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurant
    ADD CONSTRAINT restaurant_pkey PRIMARY KEY (restaurantid);


--
-- Name: uncheckedreports uncheckedreports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uncheckedreports
    ADD CONSTRAINT uncheckedreports_pkey PRIMARY KEY (reportid);


--
-- PostgreSQL database dump complete
--

