with reportsum as (
select restaurantid, sum(cleanrank) as cleansum,
       sum(busyrank) as busysum
from finalizedreports
  where date_trunc('week',submissiontime) >= 
        date_trunc('week',CURRENT_TIMESTAMP) - interval '1 week'
group by restaurantid
),
-- stinky 10pm brain fog solve
counter as (
select restaurantid, count(*) as totalreports
from finalizedreports
  where date_trunc('week',submissiontime) >= 
        date_trunc('week',CURRENT_TIMESTAMP) - interval '1 week'
group by restaurantid
)
select
  rs.restaurantid,
  ROUND(rs.cleansum / (c.totalreports),2) as cleanavg, 
  ROUND(rs.busysum / (c.totalreports),2) as busyavg
from reportsum as rs
  inner join counter as c using (restaurantid)
  inner join finalizedreports as fr using (restaurantid)
--where rs.restaurantid = 1
group by rs.restaurantid, cleanavg, busyavg
;



with latest as (
  select restaurantid, cleanrank, busyrank, submissiontime,
    rank() OVER (PARTITION BY restaurantid order by submissiontime desc) as counter
  from finalizedreports
  order by submissiontime 
)
select restaurantid, cleanrank, busyrank, submissiontime
from latest 
where counter = 1 AND 
        restaurantid = 1
order by submissiontime desc;


with reportsum as (
    select restaurantid, sum(cleanrank) as cleansum,
           sum(busyrank) as busysum
    from finalizedreports
      where date_trunc('week',submissiontime) >= 
            date_trunc('week',CURRENT_TIMESTAMP) - interval '1 week'
    group by restaurantid
    ),
    counter as (
    select restaurantid, count(*) as totalreports
    from finalizedreports
      where date_trunc('week',submissiontime) >= 
            date_trunc('week',CURRENT_TIMESTAMP) - interval '1 week'
    group by restaurantid
    )
    select
      rs.restaurantid,
      ROUND(rs.cleansum / (c.totalreports),2) as cleanavg, 
      ROUND(rs.busysum / (c.totalreports),2) as busyavg,
      ROUND((((rs.cleansum /c.totalreports)+ (rs.cleansum / c.totalreports) * 5)) / 2, 2) as algclean,
      ROUND((((rs.busysum /c.totalreports) + (rs.busysum / c.totalreports) * 5)) / 2, 2) as algbusy
    from reportsum as rs
      inner join counter as c using (restaurantid)
      inner join finalizedreports as fr using (restaurantid)
    where rs.restaurantid = $1
    group by rs.restaurantid, cleanavg, busyavg, algclean, algbusy
    ;
    -- + (rs.busysum / c.totalreports)
    -- + (rs.cleansum / c.totalreports)

    -- old 
    with reportsum as (
    select restaurantid, sum(cleanrank) as cleansum,
           sum(busyrank) as busysum
    from finalizedreports
      where date_trunc('week',submissiontime) >= 
            date_trunc('week',CURRENT_TIMESTAMP) - interval '1 week'
    group by restaurantid
    ),
    counter as (
    select restaurantid, count(*) as totalreports
    from finalizedreports
      where date_trunc('week',submissiontime) >= 
            date_trunc('week',CURRENT_TIMESTAMP) - interval '1 week'
    group by restaurantid
    )
    select
      rs.restaurantid,
      ROUND(rs.cleansum / (c.totalreports),2) as cleanavg, 
      ROUND(rs.busysum / (c.totalreports),2) as busyavg
    from reportsum as rs
      inner join counter as c using (restaurantid)
      inner join finalizedreports as fr using (restaurantid)
    where rs.restaurantid = $1
    group by rs.restaurantid, cleanavg, busyavg
    ;