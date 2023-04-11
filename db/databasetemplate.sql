--
-- PostgreSQL database dump
--
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE SCHEMA linehop;
CREATE SEQUENCE avgarchive_archid_seq;

--
-- Name: restaurant; Type: TABLE; Schema: linehop; Owner: postgres
--

CREATE TABLE linehop.restaurant (
    restaurantid bigint NOT NULL PRIMARY KEY,
    restaurantname character varying,
    cleanavg numeric,
    busyavg numeric,
    dateadded TIMESTAMP
);

--
-- Name: location; Type: TABLE; Schema: linehop; Owner: postgres
--

CREATE TABLE linehop.location (
    locationid bigint NOT NULL PRIMARY KEY,
    restaurantid bigint NOT NULL REFERENCES linehop.restaurant(restaurantid),
    address character varying,
    openhour time,
    closehour time
);



-- User table 

CREATE TABLE linehop.useraccount(
    userid uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    email CHARACTER VARYING UNIQUE,
    password CHARACTER VARYING,
    role CHARACTER VARYING,
    usercode CHARACTER VARYING
);

--
-- Name: reports; Type: TABLE; Schema: linehop; Owner: postgres
--

CREATE TABLE linehop.reports (
    reportid bigint NOT NULL PRIMARY KEY,
    restaurantid bigint NOT NULL REFERENCES linehop.restaurant(restaurantid),
    cleanrank numeric,
    busyrank numeric,
    picture VARCHAR,
    submissiontime timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    userid uuid REFERENCES linehop.useraccount(userid),
    trusted boolean
);

--
--  avgarchive 
--
CREATE TABLE linehop.avgarchive (
    archid bigint not null primary key DEFAULT NEXTVAL('avgarchive_archid_seq'), 
    restaurantid bigint NOT NULL REFERENCES linehop.restaurant(restaurantid),
    monthcount BIGINT,
    monthclean numeric, 
    monthbusy numeric
);

CREATE TABLE linehop.weightedavg (
    weightid serial not null primary key,
    restaurantid bigint NOT NULL REFERENCES linehop.restaurant(restaurantid),
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
        from linehop.reports
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
        from linehop.reports
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
    UPDATE linehop.restaurant
    SET cleanavg = ROUND(genericavgclean(resid), 2),
        busyavg = ROUND(genericavgbusy(resid), 2)
    WHERE restaurant.restaurantid = resid;
    return NEW;
END;
$$;

-- avg to rest table from report on trusted 
CREATE TRIGGER avgrestaurant
    AFTER UPDATE
    ON linehop.reports
    FOR EACH ROW 
    EXECUTE FUNCTION avgrestupdate();


-- Enable Trigger
alter table linehop.reports enable trigger all; 

--Sort clean function 1
create or replace FUNCTION sort_clean_1 (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare
	weighted_clean decimal;
BEGIN
	select monthclean
	into weighted_clean
	from linehop.avgarchive
	where restaurantid = restid;
	
	return weighted_clean;
END;
$$;
--Sort clean function 2
create or replace FUNCTION sort_clean_2 (restid BIGINT)
RETURNS decimal
language plpgsql 
as $$
declare 
	weighted_clean decimal;
BEGIN
	select SUM (weighted)
	into weighted_clean
	from (select monthcount,
		case WHEN monthcount = 1 then monthclean * (.67)
		WHEN monthcount = 2 then monthclean * (.33)
		ELSE 0
		END as weighted
		from linehop.avgarchive
		where restaurantid = restid
        group by monthcount, monthclean
	) as weight (monthcount, weighted);
	
	return weighted_clean;
END;
$$;

--Sort clean function 3

create or replace FUNCTION sort_clean_3 (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare 
	weighted_clean decimal;
BEGIN
	select SUM (weighted)
	into weighted_clean
	from (select monthcount,
		case WHEN monthcount = 1 then monthclean * (.6)
		WHEN monthcount = 2 then monthclean * (.25)
		WHEN monthcount = 3 then monthclean * (.15)
		ELSE 0
		END as weighted
		from linehop.avgarchive
	        where restaurantid = restid
		group by monthcount, monthclean
	) as weight (monthcount, weighted);
	
	return weighted_clean;
END;
$$;

--Sort clean function 4
create or replace FUNCTION sort_clean_4 (restid BIGINT)
RETURNS decimal 
language plpgsql
as $$
declare
	weighted_clean decimal;
BEGIN
	select SUM (weighted)
	into weighted_clean
	from (select monthcount,
		case WHEN monthcount = 1 then monthclean * (.5)
		WHEN monthcount = 2 then monthclean * (.3)
		WHEN monthcount = 3 then monthclean * (.15)
		WHEN monthcount = 4 then monthclean * (.05)
		ELSE 0
		END as weighted
		from linehop.avgarchive
	        where restaurantid = restid
		group by monthcount, monthclean
	) as weight (monthcount, weighted);
	
	return weighted_clean;
END;
$$;

--Sort clean function 5
create or replace FUNCTION sort_clean_5 (restid BIGINT)
RETURNS decimal 
language plpgsql
as $$
declare
	weighted_clean decimal;
BEGIN
	select SUM (weighted)
	into weighted_clean
	from (select monthcount,
		case WHEN monthcount = 1 then monthclean * (.4)
		WHEN monthcount = 2 then monthclean * (.3)
		WHEN monthcount = 3 then monthclean * (.15)
		WHEN monthcount = 4 then monthclean * (.1)
		WHEN monthcount = 5 then monthclean * (.05)
		ELSE 0
		END as weighted
		from linehop.avgarchive
	        where restaurantid = restid
		group by monthcount, monthclean
	) as weight (monthcount, weighted);

	return weighted_clean;
END;
$$;

--Sort busy function 1
create or replace FUNCTION sort_busy_1 (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare 
	weighted_busy decimal;
BEGIN
	select monthbusy 
	into weighted_busy
	from avgarchive
	where restaurantid = restid;

	return weighted_busy;
END;
$$;
--Sort busy function 2
create or replace FUNCTION sort_busy_2 (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare
	weighted_busy decimal;
BEGIN
	select SUM (weighted)
	into weighted_busy
	from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.67)
		WHEN monthcount = 2 then monthbusy * (.33)
		ELSE 0
		END as weighted
		from linehop.avgarchive
		where restaurantid = restid
        group by monthcount, monthbusy
	) as weight (monthcount, weighted);

	return weighted_busy;
END;
$$;
--Sort busy function 3
create or replace FUNCTION sort_busy_3 (restid BIGINT)
RETURNS decimal 
language plpgsql
as $$
declare 
	weighted_busy decimal;
BEGIN 
	select SUM (weighted)
	into weighted_busy
	from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.6)
		WHEN monthcount = 2 then monthbusy * (.25)
		WHEN monthcount = 3 then monthbusy * (.15)
		ELSE 0
		END as weighted
		from linehop.avgarchive
	        where restaurantid = restid
		group by monthcount, monthbusy
	) as weight (monthcount, weighted);

	return weighted_busy;
END;
$$;
--Sort busy function 4
create or replace FUNCTION sort_busy_4 (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare
	weighted_busy decimal;
BEGIN
	select SUM (weighted)
	into weighted_busy
	from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.5)
		WHEN monthcount = 2 then monthbusy * (.3)
		WHEN monthcount = 3 then monthbusy * (.15)
		WHEN monthcount = 4 then monthbusy * (.05)
		ELSE 0
		END as weighted
		from linehop.avgarchive
	        where restaurantid = restid
		group by monthcount, monthbusy
	) as weight (monthcount, weighted);

	return weighted_busy;
END;
$$;
--Sort busy function 5
create or replace FUNCTION sort_busy_5 (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare
	weighted_busy decimal;
BEGIN
	select SUM (weighted)
	into weighted_busy
	from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.4)
		WHEN monthcount = 2 then monthbusy * (.3)
		WHEN monthcount = 3 then monthbusy * (.15)
		WHEN monthcount = 4 then monthbusy * (.10)
		WHEN monthcount = 5 then monthbusy * (.05)
		ELSE 0
		END as weighted
		from avgarchive
	        where restaurantid = restid
		group by monthcount, monthbusy
	) as weight (monthcount, weighted);
	
	return weighted_busy;
END;
$$;
-- Test data 
INSERT INTO linehop.restaurant (restaurantid, restaurantname, cleanavg, busyavg, dateadded) VALUES (1, 'North Test Dining Hall', NULL, NULL, NULL);
INSERT INTO linehop.restaurant (restaurantid, restaurantname, cleanavg, busyavg, dateadded) VALUES (2, 'South Test Dining Hall', NULL, NULL, NULL);
INSERT INTO linehop.location (locationid, restaurantid, address, openhour, closehour) VALUES (1, 1, '123 street A', '06:00:00', '22:00:00');
INSERT INTO linehop.location (locationid, restaurantid, address, openhour, closehour) VALUES (2, 2, '321 street B', '10:00:00', '23:00:00');

--temporary user account (Change my email to your email for full testing..)
INSERT INTO linehop.useraccount (userid, email, password, role) VALUES ('1f903602-1e65-495a-9440-419abb17c51e', 'jakespamacc284@gmail.com', '$2b$10$x306nMO4GQzZQUdWsv0RaOy4zno0pkUq.p8XwfSoIKL305ySYFhMK', 'trusted');
--test data for report average (restaurant 1)
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2345, 1, 3.54, 2.69, '2022-11-20 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2346, 1, 1.33, 4.53, '2022-11-21 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2347, 1, 2.96, 2.95, '2022-11-22 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2348, 1, 4.41, 1.14, '2022-11-23 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
--test data for report average (restaurant 2)
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2349, 2, 3.54, 2.69, '2022-11-24 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2350, 2, 4.95, 3.41, '2022-11-25 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2351, 2, 2.46, 4.11, '2022-11-26 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2352, 2, 3.38, 1.96, '2022-11-27 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
INSERT INTO linehop.reports (reportid, restaurantid, cleanrank, busyrank, submissiontime, userid, trusted) VALUES (2353, 2, 4.05, 1.05, '2022-11-28 06:00:00-05', '1f903602-1e65-495a-9440-419abb17c51e', 't');
--one month
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 1, 1, 2.54, 3.98);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 2, 1, 1.22, 4.32);
--ID 1 averages: Clean: 2.54 Busy: 3.98
--ID 2 averages: Clean: 1.22 Busy: 4.32

--two months
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 1, 1, 4.87, 3.45);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 1, 2, 3.74, 2.98);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (3, 2, 1, 1.48, 4.21);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (4, 2, 2, 3.55, 2.78);
--ID 1 averages: Clean: 4.4971 Busy: 3.2949
--ID 2 averages: Clean: 2.1631 Busy: 3.7381

--three months
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 1, 1, 2.85, 4.43);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 1, 2, 4.63, 3.56);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (3, 1, 3, 3.18, 2.53);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (4, 2, 1, 3.62, 3.11);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (5, 2, 2, 2.93, 4.03);
--INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (6, 2, 3, 3.17, 3.98);
--ID 1 averages: Clean: 3.3445 Busy: 3.9275 
--ID 2 averages: Clean: 3.38 Busy: 3.4705

--four months
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 1, 1.46, 4.68);
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 2, 4.12, 3.58);
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 3, 3.87, 2.45);
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 4, 4.65, 4.27);
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 1, 3.49, 2.68);
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 2, 2.52, 3.24);
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 3, 4.41, 4.52);
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 4, 3.27, 4.89);
--ID 1 averages: Clean: 2.779 Busy: 3.995
--ID 2 averages: Clean: 3.326 Busy: 3.2345
--five months
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (1, 5, 2.36, 1.99);
INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) VALUES (2, 5, 1.23, 4.99);
--ID 1 averages: Clean: 2.9835 Busy: 3.84
--ID 2 averages: Clean: 3.202 Busy: 3.4605

WITH max_month AS (
	select restaurantid, max(monthcount) as long_month
	from linehop.avgarchive
	group by restaurantid
	order by restaurantid
)
INSERT INTO linehop.weightedavg (restaurantid, weightedclean, weightedbusy)
select restaurantid,
	case WHEN long_month = 1 then ROUND(sort_clean_1(restaurantid), 2)
	WHEN long_month = 2 then ROUND(sort_clean_2(restaurantid), 2)
	WHEN long_month = 3 then ROUND(sort_clean_3(restaurantid), 2)
	WHEN long_month = 4 then ROUND(sort_clean_4(restaurantid), 2)
	WHEN long_month = 5 then ROUND(sort_clean_5(restaurantid), 2)
	ELSE 0
	END as weighted_clean,

	case WHEN long_month = 1 then ROUND(sort_busy_1(restaurantid), 2)
	WHEN long_month = 2 then ROUND(sort_busy_2(restaurantid), 2)
	WHEN long_month = 3 then ROUND(sort_busy_3(restaurantid), 2)
	WHEN long_month = 4 then ROUND(sort_busy_4(restaurantid), 2)
	WHEN long_month = 5 then ROUND(sort_busy_5(restaurantid), 2)
	ELSE 0
	END as weighted_busy
from max_month
;

--Cron start

--Increment month value by 1:

SELECT cron.schedule (
'* * * * *', 
$$UPDATE linehop.avgarchive set monthcount = monthcount + 1$$
);
--Might have to rewrite as "set monthcount = row(monthcount + 1)"

--Delete data with month value > 5:

SELECT cron.schedule (
'* * * * *',
$$DELETE FROM linehop.avgarchive where monthcount > 5$$
);

--Insert into archive table: 
SELECT cron.schedule (
'* * * * *',
$$INSERT INTO linehop.avgarchive (restaurantid, monthcount, monthclean, monthbusy) select restaurantid, 1, cleanavg, busyavg FROM restaurant$$
);


