//db is named postgres
const express = require('express')
const db = require('./queries')
const bodyParser = require('body-parser')

const app = express()
const port = 3000

app.use(bodyParser.json())


//Initialize routes
app.get('/uncheckedreports', db.getUncheckedReport)

app.get('/location/:restaurantsid', db.getRestaurant)

app.get('/location', db.getLocation)

app.get('/uncheckedreports/:reportid', db.getUncheckedReportById)

app.post('/finalizedreports', db.finalizeReport)

app.get('/finalizedreports', db.getFinalizedReport)

app.get('/finalizedReports/:restaurantid', db.getFinalizedReportById)

app.post('/uncheckedreports', db.createReport)


//Verify application is running (node api.js)
app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})
