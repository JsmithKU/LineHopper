const jwt = require('jsonwebtoken')

function jwtTokens({userid,email}) {
  const user = {userid,email}
  const accessToken = jwt.sign(user,process.env.ACCESS_TOKEN_SECRET,{expiresIn:'15m'})
  const refreshToken = jwt.sign(user,process.env.REFRESH_TOKEN_SECRET,{expiresIn:'14D'})
  return ({accessToken,refreshToken})
}

module.exports = {
  jwtTokens,

}