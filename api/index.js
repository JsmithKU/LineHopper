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
const corsOptions = { credentials: true, origin: 'http://localhost:8080', exposedHeaders: ['set-cookie'] }


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
app.get('/api/refresh', userRoutes.userRefresh) // Reset Token for access from refresh token
app.delete('/api/signout', userRoutes.userSignout) // Sign out
app.put('/api/useraccount/forgotpassword', userRoutes.forgotPassword) //Forgot password -- resets password to something new
// User Routes with Auth 
app.get('/api/userrole/:userid', auth.authenticateToken, userRoutes.roleCheck) // Get user status for role 
// code check
app.get('/api/check/:useremail',userRoutes.emailcheck)
app.get('/api/verify/:useremail/:usercode',userRoutes.codeCheck)
app.get('/api/verifyrole/:email',userRoutes.verifyroleCheck) // Get user status for role 
app.put('/api/roleupdate/:email/:code', userRoutes.updateroleuser) // update role
// Core Routes
app.get('/api/locationsearch/:restaurantname', auth.authenticateToken, coreRoutes.searchLocation) //Search a location TODO: autofill search functionality
app.get('/api/uncheckedreports', auth.authenticateToken, coreRoutes.getUncheckedReport) // Get ALL reports that are untrusted
app.get('/api/location/:restaurantid', auth.authenticateToken, coreRoutes.getRestaurant) // Get a location by id
app.get('/api/location', auth.authenticateToken, coreRoutes.getLocation) // Get ALL locations
app.get('/api/uncheckedreports/:reportid', auth.authenticateToken, coreRoutes.getUncheckedReportById) // Get a report that is untrusted
app.put('/api/finalizedreports/:id', auth.authenticateToken, coreRoutes.finalizeReport) // POST a report that is trusted
app.get('/api/finalizedreports', auth.authenticateToken, coreRoutes.getFinalizedReport) // Get ALL reports that are trusted
app.get('/api/finalizedReports/:restaurantid', auth.authenticateToken, coreRoutes.getFinalizedReportById) // GET a report that is trusted
app.post('/api/uncheckedreports', auth.authenticateToken, coreRoutes.createReport) // POST a report that is untrusted
app.delete('/api/uncheckedreports/:reportid', auth.authenticateToken, coreRoutes.deleteUncheckedReport) // DELETE a report that is untrusted
app.get('/api/locationstats/:restaurantid', auth.authenticateToken, coreRoutes.getlocationstat) // Get a locations stats
app.get('/api/locationlatest/:restaurantid', auth.authenticateToken, coreRoutes.getlocationlatest) // Get a locations latest report
app.get('/api/locationdow/:restaurantid', auth.authenticateToken, coreRoutes.getlocationdowreport)
app.get('/api/location/name/:restaurantname', auth.authenticateToken,coreRoutes.getRestaurantbyName)



// Start Backend and console out
app.listen(port, () => {
    console.log(`LineHopper Backend 2023 - CSC355`)
    console.log(`App running on port ${port}.`)
})