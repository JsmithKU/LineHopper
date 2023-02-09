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
    res.status(403).send()
})
app.get('/api', (req, res) => {
    res.send('api Page.')
})

app.get('/api/uncheckedreports', db.getUncheckedReport)

app.get('/api/location/:restaurantsid', db.getRestaurant)

app.get('/api/location', db.getLocation)

app.get('/api/uncheckedreports/:reportid', db.getUncheckedReportById)

app.post('/api/finalizedreports', db.finalizeReport)

app.get('/api/finalizedreports', db.getFinalizedReport)

app.get('/api/finalizedReports/:restaurantid', db.getFinalizedReportById)

app.post('/api/uncheckedreports', db.createReport)

app.delete('/api/uncheckedreports/:reportid',db.deleteUncheckedReport)

app.get('/api/locationstats/:restaurantid', db.getlocationstat)

//getlocationlatest
app.get('/api/locationlatest/:restaurantid', db.getlocationlatest)

// dow
app.get('/api/locationdow/:restaurantid', db.getlocationdowreport)


//Verify application is running (node api.js)
app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})
