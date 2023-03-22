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
create or replace FUNCTION genericavgclean (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
BEGIN
        select avg (cleanrank) as crank
        from reports
        where restaurantid = restid;
        return crank; 
END;
$$;

create or replace FUNCTION genericavgbusy (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
BEGIN
        select avg (busyrank) as brank
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
    UPDATE restaurant
    SET cleanavg = 1,
        busyavg = 1
    WHERE restaurant.restaurantid = resid;
    return NEW;
END;
$$;

-- avg to rest table from report on trusted 
CREATE TRIGGER avgrestaurant
    AFTER UPDATE
    ON reports
    FOR EACH ROW 
    EXECUTE FUNCTION avgrestupdate(restuarantid);


-- Test data 
INSERT INTO public.restaurant (restaurantid, restaurantname, cleanavg, busyavg, dateadded) VALUES (1, 'North Test Dining Hall', NULL, NULL, NULL);
INSERT INTO public.restaurant (restaurantid, restaurantname, cleanavg, busyavg, dateadded) VALUES (2, 'South Test Dining Hall', NULL, NULL, NULL);
INSERT INTO public.location (locationid, restaurantid, address, openhour, closehour) VALUES (1, 1, '123 street A', '06:00:00', '22:00:00');
INSERT INTO public.location (locationid, restaurantid, address, openhour, closehour) VALUES (2, 2, '321 street B', '10:00:00', '23:00:00');

