// Libraries 
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const cookie = require('cookie-parser')

// Routes 
const coreRoutes = require('./routes/core.js')
const userRoutes = require('./routes/users.js')
const auth = require('./utils/authorization.js')


// create and set express config
const app = express()
const port = 3000
const corsOptions = {credentials:true, origin:'*'}


app.use(bodyParser.json())
app.use(cors(corsOptions))
app.use(cookie())


//Initialize routes
app.get('/', (req, res) => {
    res.status(403).send() // this should be cleaned up 
})
app.get('/api', (req, res) => {
    res.send('api Page.')
})

// auth: auth.authenticateToken,
// User Routes 
app.post('/api/useraccount', userRoutes.createUser) // POST a user account
app.get('/api/useraccount/:email', userRoutes.getUser) // Get a user account (by Email)
app.post('/api/login', userRoutes.userLogin) // post to login 

// Core Routes

app.get('/api/locationsearch/:restaurantname', coreRoutes.searchLocation) //Search a location TODO: autofill search functionality
app.get('/api/uncheckedreports', coreRoutes.getUncheckedReport) // Get ALL reports that are untrusted
app.get('/api/location/:restaurantid', coreRoutes.getRestaurant) // Get a location by id
app.get('/api/location', coreRoutes.getLocation) // Get ALL locations
app.get('/api/uncheckedreports/:reportid', coreRoutes.getUncheckedReportById) // Get a report that is untrusted
app.post('/api/finalizedreports', coreRoutes.finalizeReport) // POST a report that is trusted
app.get('/api/finalizedreports', coreRoutes.getFinalizedReport) // Get ALL reports that are trusted
app.get('/api/finalizedReports/:restaurantid', coreRoutes.getFinalizedReportById) // GET a report that is trusted
app.post('/api/uncheckedreports', coreRoutes.createReport) // POST a report that is untrusted
app.delete('/api/uncheckedreports/:reportid', coreRoutes.deleteUncheckedReport) // DELETE a report that is untrusted
app.get('/api/locationstats/:restaurantid', coreRoutes.getlocationstat) // Get a locations stats
app.get('/api/locationlatest/:restaurantid', coreRoutes.getlocationlatest) // Get a locations latest report
app.get('/api/locationdow/:restaurantid', coreRoutes.getlocationdowreport) // Get a locations stat by Day of Week


// Start Backend and console out
app.listen(port, () => {
    console.log(`LineHopper Backend 2023 - CSC355`)
    console.log(`App running on port ${port}.`)
})