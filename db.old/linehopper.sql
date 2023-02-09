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

CREATE TABLE public.finalizedreports (
    reportid bigint NOT NULL,
    restaurantid bigint,
    cleanrank numeric,
    busyrank numeric,
    picture boolean
);


--
-- Name: location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.location (
    restaurantid bigint NOT NULL,
    address character varying,
    hoursopen character varying
);


--
-- Name: restaurant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.restaurant (
    restaurantid bigint NOT NULL,
    name character varying,
    cleanavg numeric,
    busyavg numeric
);


--
-- Name: uncheckedreports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uncheckedreports (
    reportid bigint NOT NULL,
    restaurantid bigint,
    cleanrank numeric,
    busyrank numeric,
    picture boolean
);


--
-- Data for Name: finalizedreports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture) FROM stdin;
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.location (restaurantsid, address, hoursopen) FROM stdin;
\.


--
-- Data for Name: restaurant; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.restaurant (restaurantid, name, cleanavg, busyavg) FROM stdin;
\.


--
-- Data for Name: uncheckedreports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.uncheckedreports (reportid, restaurantid, cleanrank, busyrank, picture) FROM stdin;
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

