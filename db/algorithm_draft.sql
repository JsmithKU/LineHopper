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
select monthclean as "weighted_clean"
from avgarchive
where restaurantid = restaurantid
;

--Two months:

select SUM (weighted_clean) as weighted_clean_two
from (select monthcount,
		case WHEN monthcount = 1 then monthclean * (.67)
		WHEN monthcount = 2 then monthclean * (.33)
		ELSE 0
		END as "weighted_clean"
		from avgarchive
		group by monthcount
		where restaurantid = restaurantid
) as weighted (monthcount, weighted_clean)
;

--Three months:

select SUM (weighted_clean) as weighted_clean_two
from (select monthcount,
		case WHEN monthcount = 1 then monthclean * (.6)
		WHEN monthcount = 2 then monthclean * (.25)
		WHEN monthcount = 3 then monthclean * (.15)
		ELSE 0
		END as "weighted_clean"
		from avgarchive
		group by monthcount
		where restaurantid = restaurantid
) as weighted (monthcount, weighted_clean)
;

--Four months:

select SUM (weighted_clean) as weighted_clean_two
from (select monthcount,
		case WHEN monthcount = 1 then monthclean * (.5)
		WHEN monthcount = 2 then monthclean * (.3)
		WHEN monthcount = 3 then monthclean * (.15)
		WHEN monthcount = 4 then monthclean * (.05)
		ELSE 0
		END as "weighted_clean"
		from avgarchive
		group by monthcount
		where restaurantid = restaurantid
) as weighted (monthcount, weighted_clean)
;

--Five months:

select SUM (weighted_clean) as weighted_clean_two
from (select monthcount,
		case WHEN monthcount = 1 then monthclean * (.4)
		WHEN monthcount = 2 then monthclean * (.3)
		WHEN monthcount = 3 then monthclean * (.15)
		WHEN monthcount = 4 then monthclean * (.1)
		WHEN monthcount = 5 then monthclean * (.05)
		ELSE 0
		END as "weighted_clean"
		from avgarchive
		group by monthcount
		where restaurantid = restaurantid
) as weighted (monthcount, weighted_clean)
;

--Functions for weighted busy 

--One month:
select monthbusy as "weighted_busy"
from avgarchive
where restaurantid = restaurantid
;

--Two months:

select SUM (weighted_busy) as weighted_busy_two
from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.67)
		WHEN monthcount = 2 then monthbusy * (.33)
		ELSE 0
		END as "weighted_busy"
		from avgarchive
		group by monthcount
		where restaurantid = restaurantid
) as weighted (monthcount, weighted_busy)
;

--Three months:

select SUM (weighted_busy) as weighted_busy_three
from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.6)
		WHEN monthcount = 2 then monthbusy * (.25)
		WHEN monthcount = 3 then monthbusy * (.15)
		ELSE 0
		END as "weighted_busy"
		from avgarchive
		group by monthcount
		where restaurantid = restaurantid
) as weighted (monthcount, weighted_busy)
;

--Four months:

select SUM (weighted_busy) as weighted_busy_four
from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.5)
		WHEN monthcount = 2 then monthbusy * (.3)
		WHEN monthcount = 3 then monthbusy * (.15)
		WHEN monthcount = 4 then monthbusy * (.05)
		ELSE 0
		END as "weighted_busy"
		from avgarchive
		group by monthcount
		where restaurantid = restaurantid
) as weighted (monthcount, weighted_busy)
;

--Five months:

select SUM (weighted_busy) as weighted_busy_five
from (select monthcount,
		case WHEN monthcount = 1 then monthbusy * (.4)
		WHEN monthcount = 2 then monthbusy * (.3)
		WHEN monthcount = 3 then monthbusy * (.15)
		WHEN monthcount = 4 then monthbusy * (.10)
		WHEN monthcount = 5 then monthbusy * (.05)
		ELSE 0
		END as "weighted_busy"
		from avgarchive
		group by monthcount
		where restaurantid = restaurantid
) as weighted (monthcount, weighted_busy)
;