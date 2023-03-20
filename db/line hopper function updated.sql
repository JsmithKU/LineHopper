--Send the subquery (of ONE restaurantid) to a function.
-Iterate through IDs one at a time (make a for loop and iterate based on the max number of restaurants)


WITH max_month AS (
	select restaurantid, max(monthcount) as long_month
	from avgarchive
	group by restaurantid
	order by restaurantid
)
select restaurantid,
	case WHEN long_month = 1 then [schema name].sort_clean_one(restaurantid)
	WHEN long_month = 2 then [schema name].sort_clean_two(restaurantid)
	WHEN long_month = 3 then [schema name].sort_clean_three(restaurantid)
	WHEN long_month = 4 then [schema name].sort_clean_four(restaurantid)
	WHEN long_month = 5 then [schema name].sort_clean_five(restaurantid)
	ELSE 0
	END as weighted_clean,

	case WHEN long_month = 1 then [schema name].sort_busy_one(restaurantid)
	WHEN long_month = 2 then [schema name].sort_busy_two(restaurantid)
	WHEN long_month = 3 then [schema name].sort_busy_three(restaurantid)
	WHEN long_month = 4 then [schema name].sort_busy_four(restaurantid)
	WHEN long_month = 5 then [schema name].sort_busy_five(restaurantid)
	ELSE 0
	END as weighted_busy
from max_month
;

--Function base name: sort_clean, sort_busy


--Functions for weighted clean 

--One month:
create or replace FUNCTION sort_clean_1 (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare
	weighted_clean decimal;
BEGIN
	select monthclean
	into weighted_clean
	from avgarchive
	where restaurantid = restid;
	
	return weighted_clean;
END;
$$;


--Two months:
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
		from avgarchive
		group by monthcount
		where restaurantid = restid
	) as weight (monthcount, weighted);
	
	return weighted_clean;
END;
$$;

--Three months:
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
		from avgarchive
		group by monthcount
		where restaurantid = restid
	) as weight (monthcount, weighted);
	
	return weighted_clean;
END;
$$;

--Four months:
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
		from avgarchive
		group by monthcount
		where restaurantid = restid
	) as weight (monthcount, weighted);
	
	return weighted_clean;
END;
$$;

--Five months:
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
		from avgarchive
		group by monthcount
		where restaurantid = restid
	) as weight (monthcount, weighted);

	return weighted_clean;
END;
$$;

--Functions for weighted busy 

--One month:
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

--Two months:
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
		from avgarchive
		group by monthcount
		where restaurantid = restid
	) as weight (monthcount, weighted);

	return weighted_busy;
END;
$$;

--Three months:
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
		from avgarchive
		group by monthcount
		where restaurantid = restid
	) as weight (monthcount, weighted);

	return weighted_busy;
END;
$$;

--Four months:
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
		from avgarchive
		group by monthcount
		where restaurantid = restid
	) as weight (monthcount, weighted);

	return weighted_busy;
END;
$$;

--Five months:
create or replace FUNCTION sort_busy_5 (restid BIGINT)
RETURNS decimal
language plpgsql
as $$
declare
	weighted_busy decimal;
BEGIN
	select SUM (weighted)
	from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.4)
		WHEN monthcount = 2 then monthbusy * (.3)
		WHEN monthcount = 3 then monthbusy * (.15)
		WHEN monthcount = 4 then monthbusy * (.10)
		WHEN monthcount = 5 then monthbusy * (.05)
		ELSE 0
		END as weighted
		from avgarchive
		group by monthcount
		where restaurantid = restid
	) as weight (monthcount, weighted);
	
	return weighted_busy;
END;
$$;