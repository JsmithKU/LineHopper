const jwt = require('jsonwebtoken')

function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'] // Bearer TOKEN
  const token = authHeader && authHeader.split(' ')[1] // check for null then split valid auth for token 
  if (token == null) return res.status(403).json({ error: "Null Token, You are not signed-in." }) // if null gets by 
  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (error, user) => {
    if (error) return res.status(403).json({ error: error.message })
    req.user = user
    next()
  })
}

module.exports = {
  authenticateToken,

}