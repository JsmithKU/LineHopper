--
-- PostgreSQL database dump
--

CREATE SCHEMA public;

--
-- TOC entry 234 (class 1259 OID 24606)
-- Name: finalizedreports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finalizedreports (
    reportid bigint NOT NULL,
    restaurantid bigint,
    cleanrank numeric,
    busyrank numeric,
    picture boolean,
    submissiontime timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.finalizedreports OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 24611)
-- Name: location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location (
    restaurantsid bigint NOT NULL,
    address character varying,
    hoursopen character varying
);


ALTER TABLE public.location OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 24616)
-- Name: restaurant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restaurant (
    restaurantid bigint NOT NULL,
    name character varying,
    cleanavg numeric,
    busyavg numeric
);


ALTER TABLE public.restaurant OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24621)
-- Name: uncheckedreports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uncheckedreports (
    reportid bigint NOT NULL,
    restaurantid bigint,
    cleanrank numeric,
    busyrank numeric,
    picture boolean,
    submissiontime timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.uncheckedreports OWNER TO postgres;

--
-- TOC entry 3378 (class 0 OID 24606)
-- Dependencies: 234
-- Data for Name: finalizedreports; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2504903389, 1, 1, 4.5, false, '2022-12-01 17:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2505145795, 1, 3.5, 1, false, '2022-12-03 14:53:17-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2505145830, 1, 3.5, 1, false, '2022-12-03 14:53:40-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16700977291, 1, 4, 0, false, '2022-12-03 15:02:09-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16700978421, 1, 1, 4, false, '2022-12-03 15:04:02-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16700978511, 1, 1.5, 3.5, false, '2022-12-03 15:04:02-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16700978601, 1, 4, 2, false, '2022-12-03 15:04:02-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701006541, 1, 3.5, 1.5, false, '2022-12-03 15:50:54-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701035531, 1, 1, 4, false, '2022-12-03 16:39:13-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701040791, 1, 1, 4, false, '2022-12-03 16:47:59-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701044601, 2, 2.5, 2.5, false, '2022-12-03 16:54:20-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701050721, 1, 2.5, 2.5, false, '2022-12-03 17:04:32-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701051311, 2, 2.5, 2.5, false, '2022-12-03 17:05:31-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701056031, 3, 2.5, 2.5, false, '2022-12-03 17:13:23-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701061011, 2, 1, 3, false, '2022-12-03 17:21:41-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701081231, 1, 1, 3.5, false, '2022-12-03 17:55:23-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701239401, 4, 1, 4, false, '2022-12-03 22:19:00-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701239441, 5, 4, 1, false, '2022-12-03 22:19:04-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701239471, 6, 4, 1, false, '2022-12-03 22:19:07-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16701239511, 7, 2.5, 2.5, false, '2022-12-03 22:19:11-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1000, 1, 1, 5.0, false, '2022-11-28 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1001, 1, 2, 3.5, false, '2022-11-28 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1002, 1, 2, 4.5, false, '2022-11-28 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1010, 2, 1, 5.0, false, '2022-11-28 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1012, 2, 2, 4.5, false, '2022-11-28 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1020, 3, 1, 5.0, false, '2022-11-28 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1021, 3, 2, 3.5, false, '2022-11-28 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1022, 3, 2, 4.5, false, '2022-11-28 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1031, 4, 2, 3.5, false, '2022-11-28 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1032, 4, 2, 4.5, false, '2022-11-28 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1040, 5, 1, 5.0, false, '2022-11-28 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1042, 5, 2, 4.5, false, '2022-11-28 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1050, 6, 1, 5.0, false, '2022-11-28 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1051, 6, 2, 3.5, false, '2022-11-28 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1052, 6, 2, 4.5, false, '2022-11-28 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1060, 7, 1, 5.0, false, '2022-11-28 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1061, 7, 2, 3.5, false, '2022-11-28 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1100, 1, 1, 5.0, false, '2022-11-29 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1101, 1, 2, 3.5, false, '2022-11-29 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1102, 1, 2, 4.5, false, '2022-11-29 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1110, 2, 1, 5.0, false, '2022-11-29 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1111, 2, 2, 3.5, false, '2022-11-29 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1120, 3, 1, 5.0, false, '2022-11-29 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1121, 3, 2, 3.5, false, '2022-11-29 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1122, 3, 2, 4.5, false, '2022-11-29 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1130, 4, 1, 5.0, false, '2022-11-29 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1140, 5, 1, 5.0, false, '2022-11-29 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1141, 5, 2, 3.5, false, '2022-11-29 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1142, 5, 2, 4.5, false, '2022-11-29 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1151, 6, 2, 3.5, false, '2022-11-29 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1152, 6, 2, 4.5, false, '2022-11-29 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1161, 7, 2, 3.5, false, '2022-11-29 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2100, 1, 1, 5.0, false, '2022-11-30 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2101, 1, 2, 3.5, false, '2022-11-30 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2102, 1, 2, 4.5, false, '2022-11-30 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2110, 2, 1, 5.0, false, '2022-11-30 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2111, 2, 2, 3.5, false, '2022-11-30 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2112, 2, 2, 4.5, false, '2022-11-30 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2120, 3, 1, 5.0, false, '2022-11-30 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2121, 3, 2, 3.5, false, '2022-11-30 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2122, 3, 2, 4.5, false, '2022-11-30 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2130, 4, 1, 5.0, false, '2022-11-30 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2131, 4, 2, 3.5, false, '2022-11-30 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2132, 4, 2, 4.5, false, '2022-11-30 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2140, 5, 1, 5.0, false, '2022-11-30 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2141, 5, 2, 3.5, false, '2022-11-30 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2142, 5, 2, 4.5, false, '2022-11-30 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2150, 6, 1, 5.0, false, '2022-11-30 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2151, 6, 2, 3.5, false, '2022-11-30 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2152, 6, 2, 4.5, false, '2022-11-30 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2160, 7, 1, 5.0, false, '2022-11-30 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2161, 7, 2, 3.5, false, '2022-11-30 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (2162, 7, 2, 4.5, false, '2022-11-30 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3100, 1, 1, 5.0, false, '2022-12-01 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3101, 1, 2, 3.5, false, '2022-12-01 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3102, 1, 2, 4.5, false, '2022-12-01 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3110, 2, 1, 5.0, false, '2022-12-01 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3111, 2, 2, 3.5, false, '2022-12-01 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3112, 2, 2, 4.5, false, '2022-12-01 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3120, 3, 1, 5.0, false, '2022-12-01 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3121, 3, 2, 3.5, false, '2022-12-01 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3122, 3, 2, 4.5, false, '2022-12-01 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3130, 4, 1, 5.0, false, '2022-12-01 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3131, 4, 2, 3.5, false, '2022-12-01 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3132, 4, 2, 4.5, false, '2022-12-01 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3140, 5, 1, 5.0, false, '2022-12-01 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3141, 5, 2, 3.5, false, '2022-12-01 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3142, 5, 2, 4.5, false, '2022-12-01 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3150, 6, 1, 5.0, false, '2022-12-01 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3151, 6, 2, 3.5, false, '2022-12-01 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3152, 6, 2, 4.5, false, '2022-12-01 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3160, 7, 1, 5.0, false, '2022-12-01 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3161, 7, 2, 3.5, false, '2022-12-01 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (3162, 7, 2, 4.5, false, '2022-12-01 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4100, 1, 1, 5.0, false, '2022-12-02 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4101, 1, 2, 3.5, false, '2022-12-02 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4102, 1, 2, 4.5, false, '2022-12-02 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4110, 2, 1, 5.0, false, '2022-12-02 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4111, 2, 2, 3.5, false, '2022-12-02 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4112, 2, 2, 4.5, false, '2022-12-02 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4120, 3, 1, 5.0, false, '2022-12-02 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4121, 3, 2, 3.5, false, '2022-12-02 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1011, 2, 3, 3.5, false, '2022-11-28 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1030, 4, 5, 5.0, false, '2022-11-28 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1041, 5, 4, 3.5, false, '2022-11-28 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1062, 7, 4, 4.5, false, '2022-11-28 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1112, 2, 4, 4.5, false, '2022-11-29 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1131, 4, 2, 2, false, '2022-11-29 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1132, 4, 5, 4.5, false, '2022-11-29 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4122, 3, 2, 4.5, false, '2022-12-02 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4130, 4, 1, 5.0, false, '2022-12-02 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4131, 4, 2, 3.5, false, '2022-12-02 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4132, 4, 2, 4.5, false, '2022-12-02 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4140, 5, 1, 5.0, false, '2022-12-02 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4141, 5, 2, 3.5, false, '2022-12-02 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4142, 5, 2, 4.5, false, '2022-12-02 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4150, 6, 1, 5.0, false, '2022-12-02 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4151, 6, 2, 3.5, false, '2022-12-02 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4152, 6, 2, 4.5, false, '2022-12-02 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4160, 7, 1, 5.0, false, '2022-12-02 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4161, 7, 2, 3.5, false, '2022-12-02 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (4162, 7, 2, 4.5, false, '2022-12-02 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5100, 1, 1, 5.0, false, '2022-12-03 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5101, 1, 2, 3.5, false, '2022-12-03 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5102, 1, 2, 4.5, false, '2022-12-03 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5110, 2, 1, 5.0, false, '2022-12-03 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5111, 2, 2, 3.5, false, '2022-12-03 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5112, 2, 2, 4.5, false, '2022-12-03 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5120, 3, 1, 5.0, false, '2022-12-03 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5121, 3, 2, 3.5, false, '2022-12-03 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5122, 3, 2, 4.5, false, '2022-12-03 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5130, 4, 1, 5.0, false, '2022-12-03 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5131, 4, 2, 3.5, false, '2022-12-03 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5132, 4, 2, 4.5, false, '2022-12-03 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5140, 5, 1, 5.0, false, '2022-12-03 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5141, 5, 2, 3.5, false, '2022-12-03 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5142, 5, 2, 4.5, false, '2022-12-03 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5150, 6, 1, 5.0, false, '2022-12-03 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5151, 6, 2, 3.5, false, '2022-12-03 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5152, 6, 2, 4.5, false, '2022-12-03 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5160, 7, 1, 5.0, false, '2022-12-03 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5161, 7, 2, 3.5, false, '2022-12-03 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (5162, 7, 2, 4.5, false, '2022-12-03 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6100, 1, 1, 5.0, false, '2022-12-04 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6101, 1, 2, 3.5, false, '2022-12-04 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6102, 1, 2, 4.5, false, '2022-12-04 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6110, 2, 1, 5.0, false, '2022-12-04 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6111, 2, 2, 3.5, false, '2022-12-04 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6112, 2, 2, 4.5, false, '2022-12-04 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6120, 3, 1, 5.0, false, '2022-12-04 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6121, 3, 2, 3.5, false, '2022-12-04 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6122, 3, 2, 4.5, false, '2022-12-04 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6130, 4, 1, 5.0, false, '2022-12-04 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6131, 4, 2, 3.5, false, '2022-12-04 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6132, 4, 2, 4.5, false, '2022-12-04 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6140, 5, 1, 5.0, false, '2022-12-04 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6141, 5, 2, 3.5, false, '2022-12-04 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6142, 5, 2, 4.5, false, '2022-12-04 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6150, 6, 1, 5.0, false, '2022-12-04 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6151, 6, 2, 3.5, false, '2022-12-04 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6152, 6, 2, 4.5, false, '2022-12-04 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6160, 7, 1, 5.0, false, '2022-12-04 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6161, 7, 2, 3.5, false, '2022-12-04 11:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (6162, 7, 2, 4.5, false, '2022-12-04 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1150, 6, 4, 5.0, false, '2022-11-29 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1160, 7, 1, 2, false, '2022-11-29 05:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (1162, 7, 5, 4.5, false, '2022-11-29 18:59:53-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16702832411, 1, 1, 3, false, '2022-12-05 18:34:01-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16702832491, 3, 1.5, 4, false, '2022-12-05 18:34:09-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16702832591, 5, 0.5, 4.5, false, '2022-12-05 18:34:19-05');
INSERT INTO public.finalizedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16702832631, 6, 3.5, 1.5, false, '2022-12-05 18:34:23-05');


--
-- TOC entry 3379 (class 0 OID 24611)
-- Dependencies: 235
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.location (restaurantsid, address, hoursopen) VALUES (1, '123 street A', '1am-10pm');
INSERT INTO public.location (restaurantsid, address, hoursopen) VALUES (2, 'McFarland Student Building', '7am-7pm');
INSERT INTO public.location (restaurantsid, address, hoursopen) VALUES (3, 'Schaeffer Ln', '10:30am-2pm');
INSERT INTO public.location (restaurantsid, address, hoursopen) VALUES (4, 'South Dining Hall', NULL);
INSERT INTO public.location (restaurantsid, address, hoursopen) VALUES (5, 'South Dining Hall', NULL);
INSERT INTO public.location (restaurantsid, address, hoursopen) VALUES (6, 'South Dining Hall', '7am-7pm');
INSERT INTO public.location (restaurantsid, address, hoursopen) VALUES (7, 'South Dining Hall', '8pm-1am');


--
-- TOC entry 3380 (class 0 OID 24616)
-- Dependencies: 236
-- Data for Name: restaurant; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.restaurant (restaurantid, name, cleanavg, busyavg) VALUES (1, 'Test Dining Hall', NULL, NULL);
INSERT INTO public.restaurant (restaurantid, name, cleanavg, busyavg) VALUES (2, 'Cub Cafe', NULL, NULL);
INSERT INTO public.restaurant (restaurantid, name, cleanavg, busyavg) VALUES (3, 'Forum Food Court', NULL, NULL);
INSERT INTO public.restaurant (restaurantid, name, cleanavg, busyavg) VALUES (4, 'South Dining Hall', NULL, NULL);
INSERT INTO public.restaurant (restaurantid, name, cleanavg, busyavg) VALUES (5, 'Avalanche', NULL, NULL);
INSERT INTO public.restaurant (restaurantid, name, cleanavg, busyavg) VALUES (6, 'Sunnysides', NULL, NULL);
INSERT INTO public.restaurant (restaurantid, name, cleanavg, busyavg) VALUES (7, 'Hearth Deli', NULL, NULL);


--
-- TOC entry 3381 (class 0 OID 24621)
-- Dependencies: 237
-- Data for Name: uncheckedreports; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.uncheckedreports (reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) VALUES (16703687431, 1, 0.5, 3.5, false, '2022-12-06 18:19:03-05');


--
-- TOC entry 3229 (class 2606 OID 24627)
-- Name: finalizedreports finalizedreports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finalizedreports
    ADD CONSTRAINT finalizedreports_pkey PRIMARY KEY (reportid);


--
-- TOC entry 3231 (class 2606 OID 24629)
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (restaurantsid);


--
-- TOC entry 3233 (class 2606 OID 24631)
-- Name: restaurant restaurant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurant
    ADD CONSTRAINT restaurant_pkey PRIMARY KEY (restaurantid);


--
-- TOC entry 3235 (class 2606 OID 24633)
-- Name: uncheckedreports uncheckedreports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uncheckedreports
    ADD CONSTRAINT uncheckedreports_pkey PRIMARY KEY (reportid);


-- Completed on 2023-02-03 11:25:32

--
-- PostgreSQL database dump complete
--

