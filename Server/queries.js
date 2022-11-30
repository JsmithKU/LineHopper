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
        pool.query('SELECT * from uncheckedReports order by reportid asc', (error, results) => {
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


    const { reportid, resturantid, cleanrank, busyrank, picture, submissiontime } = req.body

    pool.query("insert into uncheckedReports(reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) values ($1,$2,$3,$4,$5,$6)", [reportid, resturantid, cleanrank, busyrank, picture, submissiontime],



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

        const { reportid, resturantid, cleanrank, busyrank, picture, submissiontime } = req.body

        pool.query("insert into finalizedreports(reportid, restaurantid, cleanrank, busyrank, picture, submissiontime) values ($1,$2,$3,$4,$5,$6)", [reportid, resturantid, cleanrank, busyrank, picture, submissiontime],

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



module.exports = {


    getUncheckedReport,
    getLocation,
    createReport,
    getRestaurant,
    finalizeReport,
    getFinalizedReport,
    getFinalizedReportById,
    getUncheckedReportById

}
