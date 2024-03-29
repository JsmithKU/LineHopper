/* 
 * Creating the POOL and other MISC sql for clean code within the queries.js 
 */

const pg = require('pg')
const { Pool } = pg

// let localPoolconfig = {
//   user: 'postgres',
//   password: '',
//   host: 'localhost',
//   port: '5432',
//   database: '' 
// }
let containerPool = {
    user: process.env.user,
    host: process.env.host,
    database: process.env.pgdb,
    password: process.env.pass,
    port: process.env.port
}

// const poolConfig = process.env.host ? containerPool : localPoolconfig;

const pool = new Pool(containerPool) // poolConfig)



// SQL 

//Forgot password 
let forgotPassword = (`
UPDATE linehop.useraccount 
set password = $1,
    usercode = null
where email = $2`);

let restaurantGET = (`
select l.restaurantid, l.address, r.restaurantname, r.cleanavg, r.busyavg 
from linehop.location as l 
  inner join linehop.restaurant as r using(restaurantid)
where restaurantid = $1
`)
let restaurantNameGET = (`
select restaurantid 
from linehop.restaurant
where restaurantname = $1
`)

let untrustedreportGET = (`
SELECT ur.reportid, ur.restaurantid, ur.cleanrank, ur.busyrank, ur.picture, r.restaurantname, ur.submissiontime, ur.userid 
from linehop.reports as ur 
  inner join linehop.restaurant as r using(restaurantid)
where ur.trusted IS NOT TRUE
order by reportid asc
`)

let locationGET = (`
select l.restaurantid, l.address, l.openhour, l.closehour, r.restaurantname, r.cleanavg, r.busyavg 
from linehop.location as l 
  inner join linehop.restaurant as r using(restaurantid) 
order by l.restaurantid
`)

let reportCreate = (`
insert into linehop.reports(reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid, trusted) 
values ($1,$2,$3,$4,$5,$6,$7,$8)
`)

let reportGetOne = (`
select * from linehop.reports where reportid = $1
`)

let reportTrust = (`
UPDATE linehop.reports
SET(trusted) = ROW(true)
WHERE reportid = $1;
`)

let reportTrustedGet = (`
select * from linehop.reports where trusted is True
`)


let untrustedreportDelete = (`
DELETE from linehop.reports where reportid = $1 
`)

let getStat = `
with reportsum as (
    select restaurantid, sum(cleanrank) as cleansum,
           sum(busyrank) as busysum
    from linehop.reports
      where trusted is True AND date_trunc('week',submissiontime) >= 
            date_trunc('week',CURRENT_TIMESTAMP) - interval '1 week'
    group by restaurantid
    ),
    counter as (
    select restaurantid, count(*) as totalreports
    from linehop.reports
      where trusted is True AND date_trunc('week',submissiontime) >= 
            date_trunc('week',CURRENT_TIMESTAMP) - interval '1 week'
    group by restaurantid
    )
    select
      rs.restaurantid,
      ROUND(rs.cleansum / (c.totalreports),2) as cleanavg, 
      ROUND(rs.busysum / (c.totalreports),2) as busyavg,
      ROUND((((rs.cleansum /c.totalreports) * 5)) / 2, 2) as algclean,
      ROUND((((rs.busysum /c.totalreports) * 5)) / 2, 2) as algbusy
    from reportsum as rs
      inner join counter as c using (restaurantid)
      inner join linehop.reports as fr using (restaurantid)
    where rs.restaurantid = $1 and fr.trusted is True
    group by rs.restaurantid, cleanavg, busyavg, algclean, algbusy
    ;
`;
let getLatest = `
with latest as (
    select restaurantid, cleanrank, busyrank, submissiontime,
      rank() OVER (PARTITION BY restaurantid order by submissiontime desc) as counter
    from linehop.reports
    where trusted is True 
    order by submissiontime 
  )
  select restaurantid, cleanrank, busyrank, 
    to_char(submissiontime, 'Month') as smonth,
    to_char(submissiontime, 'DDth') as sday,
    to_char(submissiontime, 'HH24') as shour,
    to_char(submissiontime, 'MI') as sminute
  from latest 
  where counter = 1 AND 
        restaurantid = $1
  order by submissiontime desc;
`;
let getdow = `
with reportsCTE as(
select restaurantid, cleanrank as crank, busyrank as brank, submissiontime as stime,
  to_char(submissiontime, 'ID') as dowtime, -- Monday(1) Sunday(7)
  to_char(submissiontime, 'HH24') as timeofday -- 00 - 24 | 05 - 11 Breakfast, 11 - 17 Lunch, 18 - 22 Dinner, 23-04 Other
from linehop.reports
where trusted is True
),
countday as (
  select restaurantid,
    round(avg(crank),2) as cleanavg, 
    round(avg(brank),2) as busyavg,
    dowtime
  from reportsCTE
  group by dowtime, restaurantid
  order by restaurantid, dowtime
)
select restaurantid, cleanavg, busyavg, dowtime, to_char(CURRENT_TIMESTAMP - INTERVAL '1 Day', 'Day') as cday
from countday
where dowtime = to_char(CURRENT_TIMESTAMP - INTERVAL '1 Day', 'ID') AND restaurantid = $1;
`;
let getdowChart = `
with reportsCTE as(
select restaurantid, cleanrank as crank, busyrank as brank, submissiontime as stime,
  to_char(submissiontime, 'ID') as dowtime, -- Monday(1) Sunday(7)
  to_char(submissiontime, 'HH24') as timeofday,
  to_char(submissiontime, 'Day') as Dayname -- 00 - 24 | 05 - 11 Breakfast, 11 - 17 Lunch, 18 - 22 Dinner, 23-04 Other
from linehop.reports
where trusted is True
),
countday as (
  select restaurantid,
    round(avg(crank),2) as cleanavg, 
    round(avg(brank),2) as busyavg,
    dowtime,
    Dayname
  from reportsCTE
  group by dowtime, restaurantid, Dayname
  order by restaurantid, dowtime
)
select restaurantid, cleanavg, busyavg, dowtime, Dayname
from countday
where restaurantid = $1;
`;





let historyweight = `
select * from linehop.avgarchive where restaurantid = $1;
`;
let createUser = `insert into linehop.useraccount (email, password, usercode) values ($1,$2,$3) `;

let getUser = `select * from linehop.useraccount where email = $1`;

let searchLocation = `select restaurantname, restaurantid from linehop.restaurant where restaurantname = $1`;

let checkrole = `select role from linehop.useraccount where userid = $1`;
let verifyrole = `select role from linehop.useraccount where email = $1`;
let codecompare = 'select usercode from linehop.useraccount where email = $1';
let trustcompare = 'select usercode from linehop.useraccount where userid = $1';
let updaterole = (`
UPDATE linehop.useraccount
SET role = 'user'
WHERE email = $1 AND usercode = $2
`)
let updatecode = (`
UPDATE linehop.useraccount
set usercode = $2
where email = $1
`)

let updateaccounttrust = (`
UPDATE linehop.useraccount
set role = 'trusted'
where userid = $1
`)


let restaurantCreate = (`
insert into linehop.restaurant(restaurantid, restaurantname) 
values ($1,$2)
`)
let locationCreate = (`
insert into linehop.location(locationid, restaurantid, address, openhour, closehour) 
values ($1,$2,$3,$4,$5)
`)

module.exports = {
    pool,
    getStat,
    getLatest,
    getdow,
    restaurantGET,
    untrustedreportGET,
    locationGET,
    reportCreate,
    reportTrust,
    reportTrustedGet,
    reportGetOne,
    untrustedreportDelete,
    createUser,
    getUser,
    searchLocation,
    forgotPassword,
    restaurantNameGET,
    checkrole,
    codecompare,
    updaterole,
    verifyrole,
    updatecode,
    trustcompare,
    restaurantCreate,
    locationCreate,
    historyweight,
    getdowChart,
    updateaccounttrust

}
