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

//Search a restaurant by name -- TODO: 
const searchLocation = async(req, res) => {
    try {
        const resName = req.params.restaurantname
        const searchLocation = await dbconnectorJs.pool.query(dbconnectorJs.searchLocation, [resName])
        if (searchLocation.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ restaurant: searchLocation.rows })
        }
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

//Get a restaurant by it's id 
const getRestaurant = async(req, res) => {
    const id = req.params.restaurantid
    // dbconnectorJs.pool.query(dbconnectorJs.restaurantGET, [id], (error, results) => {
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     } else {
    //         res.status(200).json(results.rows)
    //     }

    // })
    try{
        const restaurantGet = await dbconnectorJs.pool.query(
            dbconnectorJs.restaurantGET,
            [id]
        )
        if(restaurantGet.rows.length === 0){
            res.json({nodata: "True"})
        }else{
            res.json({resturant: restaurantGet.rows[0]})
        }
    }catch(error){
        res.status(500).json({error: error.message})
    }
}

//Get ALL unchecked reports 
const getUncheckedReport = async(req, res) => {
    // dbconnectorJs.pool.query(dbconnectorJs.untrustedreportGET, (error, results) => {
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    //     res.status(200).json(results.rows)
    // })
    try {
        const uncheckedReports = await dbconnectorJs.pool.query(
                dbconnectorJs.getUncheckedReport
            )
            // Sends res to front-end (no data or data)
        if (uncheckedReports.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ reports: uncheckedReports.rows })
        }
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

//Get ALL restaurant locations
const getLocation = async(req, res) => {
    // dbconnectorJs.pool.query(dbconnectorJs.locationGET, (error, results) => {
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    //     res.status(200).json(results.rows)
    // })
    try{
        const locationGet = await dbconnectorJs.pool.query(
            dbconnectorJs.locationGET
        )
        if(locationGet.rows.length === 0){
            res.json({nodata: "True"})
        }else{
            res.json({location: locationGet.rows})
        }
    }catch(error){
        res.status(500).json({ error: error.message })
    }

}

//Create a new report  ( CLEAN THIS ) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const createReport = async(req, res) => {
    const { reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid } = req.body
    // dbconnectorJs.pool.query(dbconnectorJs.reportCreate, [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid, "False"],
    //     (error, results) => {
    //         if (!error) {
    //             //Send results
    //             res.status(201).json(results.rows)
    //         } else {
    //             res.status(401).json({ error: error.message })
    //         }
    //     })
    try{
        const reportCreate = await dbconnectorJs.pool.query(
            dbconnectorJs.reportCreate, 
            [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid, "False"]
        )
        res.json(reportCreate.rows)
    }catch(error){
        res.status(500).json({ error: error.message })
    }
}

//Get an unchecked report by id
const getUncheckedReportById = async(req, res) => {
    const id = req.params.reportid
    // dbconnectorJs.pool.query(dbconnectorJs.reportGetOne, [id],
    //     (error, results) => {
    //         if (!error) {
    //             //Send results
    //             res.status(200).json(results.rows)
    //         }
    //         if (error) {
    //             res.status(401).json({ error: error.message })
    //         }
    //     })
    try{
        const uncheckedReportID = await dbconnectorJs.pool.query(
            dbconnectorJs.reportGetOne, 
            [id]
        )
        if(uncheckedReportID.rows.length === 0){
            res.json({nodata: "True"})
        }else{
            res.json({reports: uncheckedReportID.rows[0]})
        }
    }catch(error){
        res.status(500).json({ error: error.message })
    }

}

//Create a finalized report ( CLEAN THIS ) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const finalizeReport = async(req, res) => {

    const { reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid } = req.body

    // dbconnectorJs.pool.query(dbconnectorJs.reportTrust, [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid, "True"],
    //     (error, results) => {
    //         if (!error) {
    //             //Send results
    //             res.status(201).json(results.rows)
    //         } else {
    //             res.status(401).json({ error: error.message })
    //         }
    //     })
    try{
        const reportTrust = await dbconnectorJs.pool.query(
            dbconnectorJs.reportTrust, 
            [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid, "True"]
        )
        if(reportTrust.rows.length === 0){
            res.json({nodata: "True"})
        }else{
            res.json({reports: reportTrust.rows[0]})
        }
    }catch(error){
        res.status(500).json({ error: error.message })
    }

}

//GET ALL finalized reports
const getFinalizedReport = async(req, res) => {
    // dbconnectorJs.pool.query(dbconnectorJs.reportTrustedGet, (error, results) => {
    //     if (!error) {
    //         //Send results
    //         res.status(200).json(results.rows)
    //     }
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    // })
    try{
        const reportTrustedGet = await dbconnectorJs.pool.query(
            dbconnectorJs.reportTrustedGet
        )
        if(reportTrustedGet.rows.length === 0){
            res.json({nodata: "True"})
        }else{
            res.json({location: reportTrustedGet.rows})
        }
    }catch(error){
        res.status(500).json({ error: error.message })
    }

}

//Get a finalized reports by restaurant id
const getFinalizedReportById = async(req, res) => {
    const id = req.params.restaurantid
    // dbconnectorJs.pool.query(dbconnectorJs.reportGetOne, [id], (error, results) => {
    //     if (!error) {
    //         res.status(200).json(results.rows)
    //     }
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    // })
    try{
        const reportGetOne = await dbconnectorJs.pool.query(
            dbconnectorJs.reportGetOne, 
            [id]
        )
        if(reportGetOne.rows.length === 0){
            res.json({nodata: "True"})
        }else{
            res.json({reports: reportGetOne.rows[0]})
        }
    }catch(error){
        res.status(500).json({ error: error.message })
    }

}

//DELETE an unchecked report
const deleteUncheckedReport = async(req, res) => {
    const id = req.params.reportid
    // dbconnectorJs.pool.query(dbconnectorJs.untrustedreportDelete, [id], (error, results) => {
    //     if (!error) {
    //         res.status(200).json(`Report number ${id} deleted`)
    //     }
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    // })
    try{
        const untrustedreportDelete = await dbconnectorJs.pool.query(
            dbconnectorJs.untrustedreportDelete,
            [id]
        )
        res.status(200).json(`Report number ${id} deleted`)

    }catch(error){
        res.status(500).json({ error: error.message })
    }

}

// get locations avg stats UPDATED THIS FOR ALG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const getlocationstat = async(req, res) => {
    const id = req.params.restaurantid
    // dbconnectorJs.pool.query(dbconnectorJs.getStat, [id], (error, results) => {
    //     if (!error) {
    //         res.status(200).json(results.rows)
    //     }
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    // })
    try{
        // Empty 
        //...
        // 200 Res 
    }catch(error){
        res.status(500).json({ error: error.message })
    }

}

//Get a finalized latest report UPDATED THIS FOR ALG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const getlocationlatest = async(req, res) => {
    const id = req.params.restaurantid
    // dbconnectorJs.pool.query(dbconnectorJs.getLatest, [id], (error, results) => {
    //     if (!error) {
    //         res.status(200).json(results.rows)
    //     }
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    // })
    try{
        // Empty 
        //...
        // 200 Res 
    }catch(error){
        res.status(500).json({ error: error.message })
    }

}

//Get a finalized dow report  UPDATED THIS FOR ALG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const getlocationdowreport = (req, res) => {
    const id = req.params.restaurantid
    // dbconnectorJs.pool.query(dbconnectorJs.getdow, [id], (error, results) => {
    //     if (!error) {
    //         res.status(200).json(results.rows)
    //     }
    //     if (error) {
    //         res.status(401).json({ error: error.message })
    //     }
    // })
    try{
        // Empty 
        //...
        // 200 Res 
    }catch(error){
        res.status(500).json({ error: error.message })
    }

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
    searchLocation,

}