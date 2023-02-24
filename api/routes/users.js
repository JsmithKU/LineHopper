// Libraries
const dbconnectorJs = require('../dbconnector.js')
const bc = require('bcrypt') // Hashing Library
const jwt = require('jsonwebtoken') // Jwt library

// Util helpers 
const jwtTokens = require('../utils/jwt-helper.js')

//Post a new user
const createUser = async (req, res) => {
  try{
      const {email, password, role} = req.body
      const hashedPassword = await bc.hash(password,10)
      const createdUser = await dbconnectorJs.pool.query(
          dbconnectorJs.createUser,
          [email, hashedPassword, role] // Data from post (Removed User id and replaced with autogen uuid check ./db/dump.sql for more info)
      ) 
      res.json({useraccount: createdUser.rows[0]}) // returns user data on creation ( this should not be given back (contains hash pretty sure) )
  }catch(error){
      res.status(500).json({error:error.message})
  }
}

// Get user (by email) this route maybe should be disabled since it exposes info without auth 
// This route could be saved for when a user wants to update account needs to match token and user id etc
const getUser = async(req, res) => { // authenticateToken, async (req,res)=>{ 
    try{
      const email = req.params.email
      const user = await dbconnectorJs.pool.query(
        dbconnectorJs.getUser,
        [email]
      )
      res.json({useraccount: user.rows[0]})
    }catch(error){
      res.status(500).json({error:error.message})
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
const userLogin = async(req,res)=>{
  try{
    const {email,password} = req.body
    const users = await dbconnectorJs.pool.query(
      dbconnectorJs.getUser,
      [email]
    )
    if(users.rows.length === 0) {return res.status(401).json({error: "Email is Invalid"})}
    // Pass check
    const validPassword = await bc.compare(password, users.rows[0].password)
    if(!validPassword) {return res.status(401).json({error: "Incorrect Password."})}
    // JWT 
    let tokens = jwtTokens.jwtTokens(users.rows[0])
    // Set cookie
    res.cookie('refresh_token', tokens.refreshToken,{httpOnly:true,sameSite: 'none', secure: true}) // set cookie
    // return tokens
    res.json(tokens)
  }catch(error){
    res.status(401).json({error:error.message}) // Forbidden Bad login 
  }
}

const userRefresh = (req,res)=>{
  try{
    const refreshToken = req.cookies.refresh_token // read from cookie
    if(refreshToken === null) return res.status(401).json({error:'Bad Token? Maybe Relog.'})
    jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET,(error,user)=>{
      if(error) return res.status(403).json({error:error.message})
      let tokens = jwtTokens.jwtTokens(user)
      res.cookie('refresh_token', tokens.refreshToken,{httpOnly:true,sameSite: 'none', secure: true})
      res.json(tokens.accessToken) 
    })
  }catch(error){
    res.status(401).json({error:error.message}) // Forbidden
  }
} 

const userSignout = (req,res)=>{
  try{
    res.clearCookie('refresh_token')
    return res.status(200).json({message:"Signed Out."})
  }catch(error){
    res.status(401).json({error:error.message}) // Forbidden
  }
}

module.exports = {

  createUser,
  getUser,
  userLogin,
  userRefresh,
  userSignout,

}