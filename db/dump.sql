--
-- PostgreSQL database dump
--
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE SCHEMA public;

--
-- TOC entry 236 (class 1259 OID 24616)
-- Name: restaurant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restaurant (
    restaurantid bigint NOT NULL PRIMARY KEY,
    restaurantname character varying,
    cleanavg numeric,
    busyavg numeric,
    dateadded TIMESTAMP
);



--
-- TOC entry 235 (class 1259 OID 24611)
-- Name: location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location (
    locationid bigint NOT NULL PRIMARY KEY,
    restaurantid bigint NOT NULL REFERENCES public.restaurant(restaurantid),
    address character varying,
    openhour time,
    closehour time
);



-- User table 

CREATE TABLE public.useraccount(
    userid uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    email CHARACTER VARYING UNIQUE,
    password CHARACTER VARYING,
    role CHARACTER VARYING
);

--
-- TOC entry 237 (class 1259 OID 24621)
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    reportid bigint NOT NULL PRIMARY KEY,
    restaurantid bigint NOT NULL REFERENCES public.restaurant(restaurantid),
    cleanrank numeric,
    busyrank numeric,
    picture VARCHAR,
    submissiontime timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    userid bigint REFERENCES public.useraccount(userid),
    trusted boolean
);

--
-- TOC entry 3380 (class 0 OID 24616)
-- Dependencies: 236
-- Data for Name: restaurant; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.restaurant (restaurantid, restaurantname, cleanavg, busyavg, dateadded) VALUES (1, 'Test Dining Hall', NULL, NULL, NULL);


--
-- TOC entry 3379 (class 0 OID 24611)
-- Dependencies: 235
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.location (locationid, restaurantid, address, openhour, closehour) VALUES (1, 1, '123 street A', '06:00:00', '22:00:00');


--
-- PostgreSQL database
--
