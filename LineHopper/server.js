//db is named postgres
const express = require('express')
const db = require('./queries')
const bodyParser = require('body-parser')
const app = express()
const port = 3000




//Initialize routes
app.get('/uncheckedreports', db.getUncheckedReport)

app.get('/location', db.getLocation)

//app.post('/uncheckedreports',db.createReport)
//Verify application is running (node api.js)
app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})
