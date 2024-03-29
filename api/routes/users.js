// Libraries
const dbconnectorJs = require('../dbconnector.js')
const bc = require('bcrypt') // Hashing Library
const jwt = require('jsonwebtoken') // Jwt library
const mailjet = require('node-mailjet')
const CryptoJS = require("crypto-js");
// Util helpers 
const jwtTokens = require('../utils/jwt-helper.js')
//const emailer = require('./emailer.js')

const mj = mailjet.apiConnect(
    // process.env.MJ_APIKEY_PUBLIC,
    // process.env.MJ_APIKEY_PRIVATE
)

function sendEmail(emailto, code){
    mj.post('send', { version: 'v3.1' }).request({
      Messages: [
        {
          From: {
            Email: 'noreply@linehopperku.com',
            Name: 'LineHopper(csc355)',
          },
          To: [
            {
              Email: `${emailto}`,
              Name: 'You',
            },
          ],
          Subject: 'LineHopper Verify (CSC355 Project)',
          TextPart: 'Greetings from LH',
          HTMLPart:
            `<h3>Dear User, Your Code: ${code}</h3><br />`,
        },
      ],
    }).then(result => {
        //console.log(result.body) // Uncomment for dev checking email status (should be 200 if sent)

      })
      .catch(err => {
        console.log(err) // catch all error 
      })
  }

//Post a new user
const createUser = async(req, res) => {
    try {
        const { email, password, usercode } = req.body
        let bytes = CryptoJS.AES.decrypt(password, "ThisISsuperSafe")
        let password1 = bytes.toString(CryptoJS.enc.Utf8);
        const hashedPassword = await bc.hash(password1, 10)
        const createdUser = await dbconnectorJs.pool.query(
            dbconnectorJs.createUser, [email, hashedPassword, usercode] // Data from post (Removed User id and replaced with autogen uuid check ./db/dump.sql for more info)
        )
        //emailer.sendEmail(email, role) //role is code currently
        sendEmail(email,usercode)
        res.json({ useraccount: createdUser.rows[0] }) // returns user data on creation ( this should not be given back (contains hash pretty sure) )
    
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

// Get user (by email) this route maybe should be disabled since it exposes info without auth 
// This route could be saved for when a user wants to update account needs to match token and user id etc
const getUser = async(req, res) => { // authenticateToken, async (req,res)=>{ 
    try {
        const email = req.params.email
        const user = await dbconnectorJs.pool.query(
            dbconnectorJs.getUser, [email]
        )
        res.json({ useraccount: user.rows[0] })
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
    // const email = req.params.email
    // dbconnectorJs.pool.query(dbconnectorJs.getUser, [email], (error, results) => {
    //         if (!error) {
    //             res.status(200).json(results.rows)
    //         } else {
    //             res.status(404).json({ error: error.message })
    //         }
    //     }
    // )
}

// Login (post)
const userLogin = async(req, res) => {
    try {

        const { email, password } = req.body
        console.log(password)
        let bytes = CryptoJS.AES.decrypt(password, "ThisISsuperSafe")
        console.log(bytes)
        let password1 = bytes.toString(CryptoJS.enc.Utf8);
        console.log(password1)
        const users = await dbconnectorJs.pool.query(
            dbconnectorJs.getUser, [email]
        )
        if (users.rows.length === 0) { return res.status(401).json({ error: "Email is Invalid" }) }
        // Pass check
        const validPassword = await bc.compare(password1, users.rows[0].password)
        if (!validPassword) { return res.status(401).json({ error: "Incorrect Password." }) }
        // JWT 
        let tokens = jwtTokens.jwtTokens(users.rows[0])
            // Set cookie
        res.cookie('refresh_token', tokens.refreshToken, {
                maxAge: 3600000 * 24 * 14,
                httpOnly: true,

                sameSite: 'none',
                secure: true
            }) // set cookie
            // return tokens and info
        const user = users.rows[0]
        // console.log(user)
        // console.log(user.role)
        if(user.role == 'user'){
            res.json({ tokens: tokens, uuid: user.userid })
        }
        else if (user.role == 'trusted'){
            res.json({tokens: tokens, uuid: user.userid, mode: 'trusted'})
        }
        else{
            throw new Error('Account Not Confirmed.')
        }
    } catch (error) {
        console.log(error)
        res.status(401).json({ error: error.message }) // Forbidden Bad login 
    }
}

const userRefresh = (req, res) => {
    try {
        const refreshToken = req.cookies.refresh_token // read from cookie
        if (refreshToken === null) return res.status(401).json({ error: 'Bad Token? Maybe Relog.' })
        jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (error, user) => {
            if (error) return res.status(403).json({ error: error.message })
            let tokens = jwtTokens.jwtTokens(user)
                // Set cookie
            res.cookie('refresh_token', tokens.refreshToken, {
                    maxAge: 3600000 * 24 * 14,
                    httpOnly: true,
                    sameSite: 'none',
                    secure: true
                }) // set cookie
            res.json({ token: tokens.accessToken, useremail: user.email, userid: user.userid })
        })
    } catch (error) {
        res.status(401).json({ error: error.message }) // Forbidden
    }
}

const userSignout = (req, res) => {
    try {
        res.clearCookie('refresh_token')
        return res.status(200).json({ message: "Signed Out." })
    } catch (error) {
        res.status(401).json({ error: error.message }) // Forbidden
    }
}

//mailer code function
// sendEmail(email,code)
const emailcode = async(req, res) => {
    const email = req.params.email
    let codegen = Math.floor(100000 + Math.random() * 900000)
    try{
        console.log("Process: Trying to send mail...")
        await dbconnectorJs.pool.query(
            dbconnectorJs.updatecode,
            [email, codegen]
        )
        sendEmail(email, codegen)
        res.json({"status": "true"})
    } catch (error){
        res.json({error: 'Unable To Send Email'}) // I do not know what would cause this other than sendEmail failing. 
    }
}

const forgotPassword = async(req, res) => {
  //Email is paramaterized for put request -- user specific
  const { password, email, code } = req.body
  const hashedPassword = await bc.hash(password, 10)
  // const newPassword = req.body.newPassword
  // const email = req.body.email
  try{
    const checkcode1 = await dbconnectorJs.pool.query(
        dbconnectorJs.codecompare,
        [email]
    )
    // console.log(checkcode1.rows)
    // console.log(checkcode1.rows[0])
    
    if(code == checkcode1.rows[0].usercode){
        const updatePassword = await dbconnectorJs.pool.query(
            dbconnectorJs.forgotPassword,
            [hashedPassword, email]
        )
        res.json({ account: updatePassword.rows })
    }else{
        throw new Error('Bad Code')
    }
  }catch(error)
  {
    res.status(500).json({ error: error.message })
  }
  
}
const roleCheck = async(req,res) =>{
    const userid = req.params.userid 
    try{
        const role = await dbconnectorJs.pool.query(
            dbconnectorJs.checkrole,
            [userid]
        )
        res.json({role: role.rows})
    }catch (error){
        res.status(500).json({Error: error.message})
    }
}

const emailcheck = async(req,res) =>{
    const email = req.params.email
    try{
        const user = await dbconnectorJs.pool.query(
            dbconnectorJs.getUser,
            [email]
        )
        if (user.rows.length === 0) { 
            return res.status(401).json({ error: "Email is Invalid" }) 
        }else{
            res.json({verify: 'true'})
        }
    }catch (error){
        res.status(500).json({Error: error.message})
    }
}

const codeCheck = async(req,res) =>{
    const usercode = req.params.usercode
    const useremail = req.params.useremail
    try{
        const truecode = await dbconnectorJs.pool.query(
            dbconnectorJs.codecompare,
            [useremail]
        )
        //console.log(truecode.rows[0].usercode)
        if(usercode == truecode.rows[0].usercode){
            res.json({verify: 'true'})
        }else{
            res.json({verify: 'false'})
        }
    }catch (error){
        res.status(500).json({Error: error.message})
    }
}

const trustcodeCheck = async(req,res) =>{
    const uuid = req.params.uuid
    const usercode = req.params.usercode
    try{
        const truecode = await dbconnectorJs.pool.query(
            dbconnectorJs.trustcompare,
            [uuid]
        )
        //console.log(truecode.rows[0].usercode)
        if(usercode == truecode.rows[0].usercode){
            res.json({verify: 'true'})
        }else{
            res.json({verify: 'false'})
        }
    }catch (error){
        res.status(500).json({Error: error.message})
    }
}

const verifyroleCheck = async(req,res) =>{
    const useremail = req.params.email
    try{
        const role = await dbconnectorJs.pool.query(
            dbconnectorJs.verifyrole,
            [useremail]
        )
        res.json({role: role.rows})
    }catch (error){
        res.status(500).json({Error: error.message})
    }
}
const updateroleuser = async(req,res) => {
    const email = req.params.email
    const code = req.params.code
    try{
        const update = await dbconnectorJs.pool.query(
            dbconnectorJs.updaterole,
            [email,code]
        )
        res.json({update: update.rows[0]})
    }catch (error){
        res.status(500).json({Error: error.message})
    }
}

const updatetrusted = async(req,res) => {
    const userid = req.params.userid
    try{
        const trusting = await dbconnectorJs.pool.query(
            dbconnectorJs.updateaccounttrust,
            [userid]
        )
    console.log(trusting)
        res.json({role: ' Updated. '})
    }catch(error){
        res.status(500).json({Error: error.message})
    }
}

module.exports = {

  createUser,
  getUser,
  userLogin,
  userRefresh,
  userSignout,
  forgotPassword,
  roleCheck,
  emailcode,
  codeCheck,
  emailcheck,
  verifyroleCheck,
  updateroleuser,
  trustcodeCheck,
  updatetrusted
}
