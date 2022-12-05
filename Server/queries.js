//Pool is a collection of queries, connected to our postgresql database.
const Pool = require('pg').Pool
const pool = new Pool({
    //Configs    
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: 'admin',
    port: 5432
})
//Get a restaurant by it's id 
const getRestaurant = (req, res) => {
    const id = req.params.restaurantsid
    pool.query('select l.restaurantsid, l.address, l.hoursopen, r.name, r.cleanavg, r.busyavg from location as l inner join restaurant as r on (l.restaurantsid = r.restaurantid) where restaurantsid = $1', [id], (error, results) => {
        if (error) {
            throw error
        }
        //Send results
        res.status(200).json(results.rows)
    })

}

//Get ALL unchecked reports 
const getUncheckedReport = (req, res) => {
    pool.query('SELECT ur.reportid, ur.restaurantid, ur.cleanrank, ur.busyrank, ur.picture, r.name, ur.submissiontime from uncheckedReports as ur inner join restaurant as r using(restaurantid) order by reportid asc', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).json(results.rows)
    })
}
//Get ALL restaurant locations
const getLocation = (req, res) => {

    pool.query('select l.restaurantsid, l.address, l.hoursopen, r.name, r.cleanavg, r.busyavg from location as l inner join restaurant as r on (l.restaurantsid = r.restaurantid) order by l.restaurantsid', (error, results) => {

        if (error) {
            throw error
        }
        res.status(200).json(results.rows)

    })


}
//Create a new report 
const createReport = (req, res) => {
    const { reportid, restaurantid, cleanrank, busyrank, picture, submissiontime } = req.body
    pool.query("insert into uncheckedReports(reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) values ($1,$2,$3,$4,$5,$6)", [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime],
        (error, results) => {
            if (error) {
                throw error
            }
            res.status(201).json(results.rows)
        })

}

//Get an unchecked report by id
const getUncheckedReportById = (req, res) => {
    const id = req.params.reportid
    pool.query('select * from uncheckedreports where reportid = $1', [id],

        (error, results) => {

            if (error) {
                throw error
            }
            res.status(200).json(results.rows)

        })
}
//Create a finalized report
const finalizeReport = (req, res) => {

    const { reportid, restaurantid, cleanrank, busyrank, picture, submissiontime } = req.body

    pool.query("insert into finalizedreports(reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) values ($1,$2,$3,$4,$5,$6)", [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime],

        (error, results) => {
            if (error) {
                throw error
            }
            res.status(201).json(results.rows)


        })

}
//GET ALL finalized reports
const getFinalizedReport = (req, res) => {

    pool.query('select * from finalizedreports', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).json(results.rows)
    })

}
//Get a finalized reports by restaurant id
const getFinalizedReportById = (req, res) => {
    const id = req.params.restaurantid
    pool.query('select * from finalizedreports where restaurantid = $1', [id], (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).json(results.rows)
    })
}

//DELETE an unchecked report
const deleteUncheckedReport = (req,res) => {


    const id = req.params.reportid
    
    pool.query('DELETE from uncheckedreports where reportid = $1', [id], (error, results) => {
    
    
    if (error) {
        throw error
    }
    res.status(200).json(`Report number ${id} deleted`)
    
    })
}
let getStat = `
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
      ROUND((((rs.cleansum /c.totalreports) * 5)) / 2, 2) as algclean,
      ROUND((((rs.busysum /c.totalreports) * 5)) / 2, 2) as algbusy
    from reportsum as rs
      inner join counter as c using (restaurantid)
      inner join finalizedreports as fr using (restaurantid)
    where rs.restaurantid = $1
    group by rs.restaurantid, cleanavg, busyavg, algclean, algbusy
    ;
`;
let getLatest = `
with latest as (
    select restaurantid, cleanrank, busyrank, submissiontime,
      rank() OVER (PARTITION BY restaurantid order by submissiontime desc) as counter
    from finalizedreports
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
-- get reports per restaurant and sort by DOW and TimeOfDay
with reports as(
select restaurantid, cleanrank as crank, busyrank as brank, submissiontime as stime,
  to_char(submissiontime, 'ID') as dowtime, -- Monday(1) Sunday(7)
  to_char(submissiontime, 'HH24') as timeofday -- 00 - 24 | 05 - 11 Breakfast, 11 - 17 Lunch, 18 - 22 Dinner, 23-04 Other
from finalizedreports
),
countday as (
  select restaurantid,
    round(avg(crank),2) as cleanavg, 
    round(avg(brank),2) as busyavg,
    dowtime
  from reports 
  group by dowtime, restaurantid
  order by restaurantid, dowtime
)
select restaurantid, cleanavg, busyavg, dowtime, to_char(CURRENT_TIMESTAMP, 'Day') as cday
from countday
where dowtime = to_char(CURRENT_TIMESTAMP, 'ID') AND
      restaurantid = $1;
`;
// get locations avg stats
const getlocationstat = (req, res) => {
    const id = req.params.restaurantid
    pool.query(getStat, [id], (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).json(results.rows)
    })
}
//Get a finalized latest report 
const getlocationlatest = (req, res) => {
    const id = req.params.restaurantid
    pool.query(getLatest, [id], (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).json(results.rows)
    })
}
//Get a finalized dow report 
const getlocationdowreport = (req, res) => {
    const id = req.params.restaurantid
    pool.query(getdow, [id], (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).json(results.rows)
    })
}

module.exports = {


    getUncheckedReport,
    getLocation,
    createReport,
    getRestaurant,
    finalizeReport,
    getFinalizedReport,
    getFinalizedReportById,
    getUncheckedReportById,
    deleteUncheckedReport,
    getlocationstat,
    getlocationlatest,
    getlocationdowreport,

}