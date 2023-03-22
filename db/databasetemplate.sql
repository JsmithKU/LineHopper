--
-- PostgreSQL database dump
--
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE SCHEMA public;


--
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
    role CHARACTER VARYING,
    usercode CHARACTER VARYING
);

--
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    reportid bigint NOT NULL PRIMARY KEY,
    restaurantid bigint NOT NULL REFERENCES public.restaurant(restaurantid),
    cleanrank numeric,
    busyrank numeric,
    picture VARCHAR,
    submissiontime timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    userid uuid REFERENCES public.useraccount(userid),
    trusted boolean
);

--
--  avgarchive 
--
CREATE TABLE public.avgarchive (
    archid serial not null primary key, 
    restaurantid bigint NOT NULL REFERENCES public.restaurant(restaurantid),
    monthcount BIGINT,
    monthclean numeric, 
    monthbusy numeric
);

CREATE TABLE public.weightedavg (
    weightid serial not null primary key,
    restaurantid bigint NOT NULL REFERENCES public.restaurant(restaurantid),
    weightedclean NUMERIC,
    weightedbusy NUMERIC
);

-- function avgRest Data 
-- take the avg from all trusted reports for a resaurantid 
-- create or replace FUNCTION genericavgclean (restid BIGINT)
-- RETURNS decimal
-- language plpgsql
-- as $$
-- BEGIN
--     return (select avg(cleanrank) from reports where restaurantid = restid);
-- END;
-- $$;

-- create or replace FUNCTION genericavgbusy (restid BIGINT)
-- RETURNS decimal
-- language plpgsql
-- as $$
-- BEGIN
--         return (select avg(busyrank) from reports where restaurantid = restid);
-- END;
-- $$;

--genericavgclean rewrite

create or replace FUNCTION genericavgclean(restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare
    crank decimal;
BEGIN

        select avg (cleanrank)
        into crank
        from reports
        where restaurantid = restid;
        return crank; 
END;
$$;
--genericavgbusy rewrite

create or replace FUNCTION genericavgbusy(restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare
    brank decimal;
BEGIN

        select avg (busyrank)
        into brank
        from reports
        where restaurantid = restid;
        return brank;
END;
$$;


CREATE OR REPLACE FUNCTION avgrestupdate()
RETURNS trigger LANGUAGE plpgsql as $$
DECLARE
    resid bigint;
BEGIN 
    resid := new.restaurantid;
    UPDATE restaurant
    SET cleanavg = genericavgclean(resid),
        busyavg = genericavgbusy(resid)
    WHERE restaurant.restaurantid = resid;
    return NEW;
END;
$$;

-- avg to rest table from report on trusted 
CREATE TRIGGER avgrestaurant
    AFTER UPDATE
    ON reports
    FOR EACH ROW 
    EXECUTE FUNCTION avgrestupdate();


-- Enable Trigger
alter table reports enable trigger all; 

-- Test data 
INSERT INTO public.restaurant (restaurantid, restaurantname, cleanavg, busyavg, dateadded) VALUES (1, 'North Test Dining Hall', NULL, NULL, NULL);
INSERT INTO public.restaurant (restaurantid, restaurantname, cleanavg, busyavg, dateadded) VALUES (2, 'South Test Dining Hall', NULL, NULL, NULL);
INSERT INTO public.location (locationid, restaurantid, address, openhour, closehour) VALUES (1, 1, '123 street A', '06:00:00', '22:00:00');
INSERT INTO public.location (locationid, restaurantid, address, openhour, closehour) VALUES (2, 2, '321 street B', '10:00:00', '23:00:00');

--one month
INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 1, 1, 2.54, 3.98);
INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 2, 1, 1.22, 4.32);
--ID 1 averages: Clean: 2.54 Busy: 3.98
--ID 2 averages: Clean: 1.22 Busy: 4.32
--two months
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 1, 1, 4.87, 3.45);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 1, 2, 3.74, 2.98);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (3, 2, 1, 1.48, 4.21);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (4, 2, 2, 3.55, 2.78);
--ID 1 averages: Clean: 4.4484 Busy: 3.2949
--ID 2 averages: Clean: 2.1631 Busy: 3.7381
--three months
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 1, 1, 2.85, 4.43);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 1, 2, 4.63, 3.56);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (3, 1, 3, 3.18, 2.53);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (4, 2, 1, 3.62, 3.11);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (5, 2, 2, 2.93, 4.03);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (6, 2, 3, 3.17, 3.98);
--ID 1 averages: Clean: 3.3445 Busy: 3.9275 
--ID 2 averages: Clean: 3.38 Busy: 3.4705
--four months
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 1, 1, 1.46, 4.68);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 1, 2, 4.12, 3.58);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (3, 1, 3, 3.87, 2.45);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (4, 1, 4, 4.65, 4.27);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (5, 2, 1, 3.49, 2.68);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (6, 2, 2, 2.52, 3.24);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (7, 2, 3, 4.41, 4.52);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (8, 2, 4, 3.27, 4.89);
--ID 1 averages: Clean: 2.779 Busy: 3.995
--ID 2 averages: Clean: 3.326 Busy: 3.2345
--five months
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (9, 1, 5, 2.36, 1.99);
--INSERT INTO public.avgarchive (archid, restaurantid, monthcount, monthclean, monthbusy) VALUES (10, 2, 5, 1.23, 4.99);
--ID 1 averages: Clean: 2.9835 Busy: 3.84
--ID 2 averages: Clean: 3.202 Busy: 3.4605
