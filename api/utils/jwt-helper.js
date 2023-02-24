const jwt = require('jsonwebtoken')

function jwtTokens({userid,email}) {
  const user = {userid,email}
  const accessToken = jwt.sign(user,process.env.ACCESS_TOKEN_SECRET,{expiresIn:'20s'})
  const refreshToken = jwt.sign(user,process.env.REFRESH_TOKEN_SECRET,{expiresIn:'2m'})
  return ({accessToken,refreshToken})
}

module.exports = {
  jwtTokens,

}