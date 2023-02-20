/*      Notes:
 * Tons of this could be fixed up 
 * Needs a standard format for routes 
 * Should convert over to try catch 
 * On vue display errors properly (Needs error handling in general)
 * 
 try{
  // Empty 
  //...
  // 200 Res 
 }catch(error){
  res.status(500).json(error:error.message)
 }
 */

// Libraries
const dbconnectorJs = require('../dbconnector.js')


//Get a restaurant by it's id 
const getRestaurant = (req, res) => {
    const id = req.params.restaurantid
    dbconnectorJs.pool.query(dbconnectorJs.restaurantGET, [id], (error, results) => {
        if (error) {
            res.status(401).json({ error: error.message })
        } else {
            res.status(200).json(results.rows)
        }
    })
}

//Get ALL unchecked reports 
const getUncheckedReport =(req, res) => {
    // dbconnectorJs.pool.query(dbconnectorJs.untrustedreportGET, (error, results) => {
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    //     res.status(200).json(results.rows)
    // })
    try{
        const uncheckedReports = await dbconnectorJs.pool.query(
            dbconnectorJs.getUncheckedReport
        )
        // Sends res to front-end (no data or data)
        if(uncheckedReports.rows.length === 0){
            res.json({nodata: "True"})
        }else{
            res.json({reports: uncheckedReports.rows[0]})
        }
    }catch(error){
        res.status(500).json({error:error.message})
    }
}

//Get ALL restaurant locations
const getLocation = (req, res) => {
    dbconnectorJs.pool.query(dbconnectorJs.locationGET, (error, results) => {
        if (error) {
            res.status(401).json({ error: error.message })
        }
        res.status(200).json(results.rows)
    })
}

//Create a new report  ( CLEAN THIS ) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const createReport = (req, res) => {
    const { reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid } = req.body
    dbconnectorJs.pool.query(dbconnectorJs.reportCreate, [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid, "False"],
        (error, results) => {
            if (!error) {
                //Send results
                res.status(201).json(results.rows)
            } else {
                res.status(401).json({ error: error.message })
            }
        })
}

//Get an unchecked report by id
const getUncheckedReportById =(req, res) => {
    const id = req.params.reportid
    dbconnectorJs.pool.query(dbconnectorJs.reportGetOne, [id],
        (error, results) => {
            if (!error) {
                //Send results
                res.status(200).json(results.rows)
            }
            if (error) {
                res.status(401).json({ error: error.message })
            }
        })
}

//Create a finalized report ( CLEAN THIS ) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const finalizeReport = (req, res) => {

    const { reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid } = req.body

    dbconnectorJs.pool.query(dbconnectorJs.reportTrust, [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid, "True"],
        (error, results) => {
            if (!error) {
                //Send results
                res.status(201).json(results.rows)
            } else {
                res.status(401).json({ error: error.message })
            }
        })
}

//GET ALL finalized reports
const getFinalizedReport = (req, res) => {
    dbconnectorJs.pool.query(dbconnectorJs.reportTrustedGet, (error, results) => {
        if (!error) {
            //Send results
            res.status(200).json(results.rows)
        }
        if (error) {
            res.status(401).json({ error: error.message })
        }
    })
}

//Get a finalized reports by restaurant id
const getFinalizedReportById = (req, res) => {
    const id = req.params.restaurantid
    dbconnectorJs.pool.query(dbconnectorJs.reportGetOne, [id], (error, results) => {
        if (!error) {
            res.status(200).json(results.rows)
        }
        if (error) {
            res.status(401).json({ error: error.message })
        }
    })
}

//DELETE an unchecked report
const deleteUncheckedReport = (req, res) => {
    const id = req.params.reportid
    dbconnectorJs.pool.query(dbconnectorJs.untrustedreportDelete, [id], (error, results) => {
        if (!error) {
            res.status(200).json(`Report number ${id} deleted`)
        }
        if (error) {
            res.status(401).json({ error: error.message })
        }
    })
}

// get locations avg stats
const getlocationstat = (req, res) => {
    const id = req.params.restaurantid
    dbconnectorJs.pool.query(dbconnectorJs.getStat, [id], (error, results) => {
        if (!error) {
            res.status(200).json(results.rows)
        }
        if (error) {
            res.status(401).json({ error: error.message })
        }
    })
}

//Get a finalized latest report 
const getlocationlatest = (req, res) => {
    const id = req.params.restaurantid
    dbconnectorJs.pool.query(dbconnectorJs.getLatest, [id], (error, results) => {
        if (!error) {
            res.status(200).json(results.rows)
        }
        if (error) {
            res.status(401).json({ error: error.message })
        }
    })
}

//Get a finalized dow report 
const getlocationdowreport = (req, res) => {
    const id = req.params.restaurantid
    dbconnectorJs.pool.query(dbconnectorJs.getdow, [id], (error, results) => {
        if (!error) {
            res.status(200).json(results.rows)
        }
        if (error) {
            res.status(401).json({ error: error.message })
        }
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