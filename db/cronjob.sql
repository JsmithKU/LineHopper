--Increment month value by 1:

SELECT cron.schedule (
'5 0 1 1-12 *',
UPDATE avgarchive
set monthcount = monthcount + 1
SELECT monthcount + 1;
)
--Might have to rewrite as "set monthcount = row(monthcount + 1)"

--Delete data with month value > 5:

SELECT cron.schedule (
'10 0 1 1-12 *',
DELETE FROM avgarchive
where monthcount > 5;
)

--Insert into archive table: 

SELECT cron.schedule (
'15 0 1 1-12 *',
INSERT INTO avgarchive (restaurantid, monthcount, monthclean, monthbusy)
SELECT restaurantid, 1, cleanavg, busyavg
FROM restaurant;
)
--
--(consider changing "archid" from "bigint" to "serial" for incrementing id value)
--(make "monthcount" a default value of '1')

--Delete data from reports table once a month:

--SELECT cron.schedule (
--'20 0 1 1-12 *',
--DELETE FROM reports
--)
--NOT NEEDED (will use timestamps to indicate which reports are deleted)

-- change the db in all 
update cron.job set database = 'linehoptest'; 