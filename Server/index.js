//db is named postgres
const express = require('express')
const db = require('./queries')
const bodyParser = require('body-parser')
const cors = require('cors')

const app = express()
const port = 3000

app.use(bodyParser.json())
app.use(cors())



//Initialize routes
app.get('/', (req, res) => {
    res.send('Landing Page.')
})

app.get('/uncheckedreports', db.getUncheckedReport)

app.get('/location/:restaurantsid', db.getRestaurant)

app.get('/location', db.getLocation)

app.get('/uncheckedreports/:reportid', db.getUncheckedReportById)

app.post('/finalizedreports', db.finalizeReport)

app.get('/finalizedreports', db.getFinalizedReport)

app.get('/finalizedReports/:restaurantid', db.getFinalizedReportById)

app.post('/uncheckedreports', db.createReport)

app.delete('/uncheckedreports/:reportid',db.deleteUncheckedReport)

app.get('/locationstats/:restaurantid', db.getlocationstat)

//getlocationlatest
app.get('/locationlatest/:restaurantid', db.getlocationlatest)

// dow
app.get('/locationdow/:restaurantid', db.getlocationdowreport)


//Verify application is running (node api.js)
app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})
