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
            res.json({ data: searchLocation.rows })
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
    try {
        const restaurantGet = await dbconnectorJs.pool.query(
            dbconnectorJs.restaurantGET, [id]
        )
        if (restaurantGet.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: restaurantGet.rows[0] })
        }
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

const getRestaurantbyName = async(req, res) => {
    const id = req.params.restaurantname
    try {
        const restaurantGet = await dbconnectorJs.pool.query(
            dbconnectorJs.restaurantNameGET, [id]
        )
        if (restaurantGet.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: restaurantGet.rows[0] })
        }
    } catch (error) {
        res.status(500).json({ error: error.message })
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
                dbconnectorJs.untrustedreportGET
            )
            // Sends res to front-end (no data or data)
        if (uncheckedReports.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: uncheckedReports.rows })
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
    try {
        const locationGet = await dbconnectorJs.pool.query(
            dbconnectorJs.locationGET
        )
        if (locationGet.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: locationGet.rows })
        }
    } catch (error) {
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
    try {
        const reportCreate = await dbconnectorJs.pool.query(
            dbconnectorJs.reportCreate, [reportid, restaurantid, cleanrank, busyrank, picture, submissiontime, userid, "False"]
        )
        res.json(reportCreate.rows)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

const createLocation = async(req, res) => {
    const { rid, lid, rname, raddress, ropen, rclose } = req.body
    try {
        await dbconnectorJs.pool.query(
            dbconnectorJs.restaurantCreate, [rid, rname]
        )
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
    try {
        await dbconnectorJs.pool.query(
            dbconnectorJs.locationCreate, [lid, rid, raddress, ropen, rclose]
        )
    } catch (error) {
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
    try {
        const uncheckedReportID = await dbconnectorJs.pool.query(
            dbconnectorJs.reportGetOne, [id]
        )
        if (uncheckedReportID.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: uncheckedReportID.rows[0] })
        }
    } catch (error) {
        res.status(500).json({ error: error.message })
    }

}

//Create a finalized report ( CLEAN THIS ) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const finalizeReport = async(req, res) => {

    const reportid = req.params.id

    try {
        const reportTrust = await dbconnectorJs.pool.query(
            dbconnectorJs.reportTrust, [reportid]
        )
        if (reportTrust.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: reportTrust.rows[0] })
        }
    } catch (error) {
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
    try {
        const reportTrustedGet = await dbconnectorJs.pool.query(
            dbconnectorJs.reportTrustedGet
        )
        if (reportTrustedGet.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: reportTrustedGet.rows })
        }
    } catch (error) {
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
    try {
        const reportGetOne = await dbconnectorJs.pool.query(
            dbconnectorJs.reportGetOne, [id]
        )
        if (reportGetOne.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: reportGetOne.rows[0] })
        }
    } catch (error) {
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
    try {
        const untrustedreportDelete = await dbconnectorJs.pool.query(
            dbconnectorJs.untrustedreportDelete, [id]
        )
        res.status(200).json(`Report number ${id} deleted`)

    } catch (error) {
        res.status(500).json({ error: error.message })
    }

}

// get locations avg stats UPDATED THIS FOR ALG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const getlocationstat = async(req, res) => {
    const id = req.params.restaurantid
    try {
        const reportlastest = await dbconnectorJs.pool.query(
            dbconnectorJs.getStat, [id]
        )
        if (reportlastest.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: reportlastest.rows[0] })
        }
    } catch (error) {
        res.status(500).json({ error: error.message })
    }

}
const getlocationhistory = async(req, res) => {
        const id = req.params.restaurantid
        try {
            const reportlastest = await dbconnectorJs.pool.query(
                dbconnectorJs.historyweight, [id]
            )
            if (reportlastest.rows.length === 0) {
                res.json({ nodata: "True" })
            } else {
                res.json({ data: reportlastest.rows })
            }
        } catch (error) {
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
    try {
        const reportlastest = await dbconnectorJs.pool.query(
            dbconnectorJs.getLatest, [id]
        )
        if (reportlastest.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: reportlastest.rows[0] })
        }
    } catch (error) {
        res.status(500).json({ error: error.message })
    }

}

//Get a finalized dow report  UPDATED THIS FOR ALG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const getlocationdowreport = async(req, res) => {
    const id = req.params.restaurantid
    try {
        const reportlastest = await dbconnectorJs.pool.query(
            dbconnectorJs.getdow, [id]
        )
        if (reportlastest.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: reportlastest.rows[0] })
        }
    } catch (error) {
        res.status(500).json({ error: error.message })
    }

}
const chartdow = async(req, res) => {
    const id = req.params.restaurantid
    try {
        const reportlastest = await dbconnectorJs.pool.query(
            dbconnectorJs.getdow, [id]
        )
        if (reportlastest.rows.length === 0) {
            res.json({ nodata: "True" })
        } else {
            res.json({ data: reportlastest.rows })
        }
    } catch (error) {
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
    getRestaurantbyName,
    createLocation,
    getlocationhistory,
    chartdow

}
