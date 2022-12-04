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
    where rs.restaurantid = $1
    group by rs.restaurantid, cleanavg, busyavg
    ;
`;
//Get a finalized reports by restaurant id
const getlocationstat = (req, res) => {
    const id = req.params.restaurantid
    pool.query(getStat, [id], (error, results) => {
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
}