--Send the subquery (of ONE restaurantid) to a function.
-Iterate through IDs one at a time (make a for loop and iterate based on the max number of restaurants)


WITH max_month AS (
	select restaurantid, max(monthcount) as long_month
	from avgarchive
	group by restaurantid
	order by restaurantid
)
select restaurantid,
	case WHEN long_month = 1 then [schema name].sortid(restaurantid)
	WHEN long_month = 2 then [schema name].sortid(restaurantid)
	WHEN long_month = 3 then [schema name].sortid(restaurantid)
	WHEN long_month = 4 then [schema name].sortid(restaurantid)
	WHEN long_month = 5 then [schema name].sortid(restaurantid)
	ELSE 'other'
	END as weighted_clean,

	case WHEN long_month = 1 then [schema name].sortid(restaurantid)
	WHEN long_month = 2 then [schema name].sortid(restaurantid)
	WHEN long_month = 3 then [schema name].sortid(restaurantid)
	WHEN long_month = 4 then [schema name].sortid(restaurantid)
	WHEN long_month = 5 then [schema name].sortid(restaurantid)
	ELSE 'other'
	END as weighted_busy
from max_month
;

--Function base name: sortid


--One month:
select monthclean, monthbusy, monthclean as "weighted_clean", monthbusy as "weighted_busy"
from avgarchive
where restaurantid = restaurantid
;

--Three months:

select monthcount, SUM (
	case WHEN monthcount = 1 then monthclean * (.6),
	WHEN monthcount = 2 then monthclean * (.3),
	WHEN monthcount = 3 then monthclean * (.1),
	ELSE 'other'
	END as "weighted_clean"
	),
	SUM (
	case WHEN monthcount = 1 then monthbusy * (.6),
	WHEN monthcount = 2 then monthbusy * (.3),
	WHEN monthcount = 3 then monthbusy * (.1),
	ELSE 'other'
	END as "weighted_busy"
	)
from avgarchive
group by monthcount
where restaurantid = restaurantid