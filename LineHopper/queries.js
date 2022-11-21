const Pool = require('pg').Pool
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'linehopper',
    password: 'admin',
    port: 5432
})

const getUncheckedReport = (req, res) => {
    pool.query('SELECT * from uncheckedReports order by reportid asc', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).json(results.rows)
    })
}
const getLocation = (req, res) => {

    pool.query('select l.restaurantsid, l.address, l.hoursopen, r.name, r.cleanavg, r.busyavg from location as l inner join restaurant as r on (l.restaurantsid = r.restaurantid) order by l.restaurantsid', (error, results) => {

        if (error) {
            throw error
        }
        res.status(200).json(results.rows)

    })


}

const createReport = (req, res) => {

    /*reportid bigint NOT NULL,
    restaurantid bigint,
    cleanrank numeric,
    busyrank numeric,
    picture boolean,
    submissiontime timestamp with time zone
    */
    const values = [req.body.reportid, req.body.restaurantid, req.body.cleanrank, req.body.busyrank, req.body.picture, req.body.submission]
    pool.query('insert into uncheckedReports reportid, restaurantid, cleanrank, busyrank, picture, submission values ($1, $2, $3,$4,$5,$6)',
        (error, results) => {
            if (error) {
                throw error
            }
            res.status(201).json(results.rows)


        })

}



module.exports = {


    getUncheckedReport,
    getLocation

}
