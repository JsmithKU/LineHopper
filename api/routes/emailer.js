const mailjet = require('node-mailjet')

const mj = mailjet.apiConnect(
  process.env.MJ_APIKEY_PUBLIC,
  process.env.MJ_APIKEY_PRIVATE
)



function sendEmail(emailto, code){
  const request = mj.post('send', { version: 'v3.1' }).request({
    Messages: [
      {
        From: {
          Email: 'noreply@linehopperku.com',
          Name: 'LineHopper',
        },
        To: [
          {
            Email: emailto,
            Name: 'You',
          },
        ],
        Subject: 'LineHopper Verify',
        TextPart: 'Greetings from LH',
        HTMLPart:
          `<h3>Dear User, Your Code: ${code}</h3><br />`,
      },
    ],
  })
  request
    .then(result => {
      console.log("Server Sending Email: " + result.statusCode)
    })
    .catch(err => {
      console.log(err.statusCode)
    })
}

export default{
  sendEmail,
  
}