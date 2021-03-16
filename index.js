const functions = require("firebase-functions");
var https = require('https');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.appnotifications = functions.https.onCall((data, context) => {

  var user_list = []

  data.users.forEach(element => {
    user_list.push(element);
  });
  avataUrl
  var message = { 
    app_id: "4cd671ff-1756-4e7a-8f03-f90a7bace30f",
    contents: {"en": `${data.body}`},
    headings: {"en": `${data.title}`},
    data: {"copon": `${data.copundata}`,"webUrl": `${data.webUrl}`,"avatarUrl": `${data.avatar}`},
    include_player_ids : user_list ,
  };
  sendNotification(message);
  return {
    response: "ok" + data.message,
  }
});

var sendNotification = function(data) {
  var headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Basic NWYzOGNkZDQtYTk5NC00NTMyLWIyYmUtNGFmMmRhNmU5MmI1"
  };
  
  var options = {
    host: "onesignal.com",
    port: 443,
    path: "/api/v1/notifications",
    method: "POST",
    headers: headers
  };
  
  
  var req = https.request(options, function(res) {  
    res.on('data', function(data) {
      console.log("Response:");
      console.log(JSON.parse(data));
    });
  });
  
  req.on('error', function(e) {
    console.log("ERROR:");
    console.log(e);
  });
  
  req.write(JSON.stringify(data));
  req.end();
};

