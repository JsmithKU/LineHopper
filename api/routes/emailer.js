const mailjet = require('node-mailjet')
/// FOR TESTING EMAILS ONLY 


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
          Name: 'LineHopper',
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
      console.log(result.body)
    })
    .catch(err => {
      console.log(err.statusCode)
    })
}
sendEmail('emailhere', 102933)