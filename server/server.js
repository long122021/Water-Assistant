// import dependencies and initialize express
const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');

const swaggerRoutes = require('./routes/swagger-route');

const waterMachineRoutes = require('./routes/waterMachine-route');
const waterInfoRoutes = require('./routes/waterInfo-route');
const waterInfoDetailRoutes = require('./routes/waterInfoDetail-route');

const app = express();

var nano = require("nano")("https://apikey-v2-2wu3flrwmexhknlyutndgj85wkwh0w7l8dco7ysfr1sd:8ab5d55fc00e3b747770fbc06cb07e29@ae563c14-9daf-4891-80cd-ac3a4c41dd2c-bluemix.cloudantnosqldb.appdomain.cloud");
global.db = nano.db.use("db_water");

// enable parsing of http request body
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// routes and api calls
app.use('/health', healthRoutes);
app.use('/swagger', swaggerRoutes);

app.use('/waterMachine', waterMachineRoutes);
app.use('/waterInfo', waterInfoRoutes);
app.use('/waterInfoDetail', waterInfoDetailRoutes);

// default path to serve up index.html (single page application)
app.all('', (req, res) => {
  res.status(200).sendFile(path.join(__dirname, '../public', 'index.html'));
});

// start node server
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`App UI available http://localhost:${port}`);
  console.log(`Swagger UI available http://localhost:${port}/swagger/api-docs`);
});

// error handler for unmatched routes or api calls
app.use((req, res, next) => {
  res.sendFile(path.join(__dirname, '../public', '404.html'));
});

module.exports = app;

// app.get('/waterMachine', function(request, response) {
//   var doc = request.query.id;
//   var key = request.query.key;
//
//   db.attachment.get(doc, key, function(err, body) {
//     if (err) {
//       response.status(500);
//       response.setHeader('Content-Type', 'text/plain');
//       response.write('Error: ' + err);
//       response.end();
//       return;
//     }
//
//     response.status(200);
//     response.setHeader("Content-Disposition", 'inline; filename="' + key + '"');
//     response.write(body);
//     response.end();
//     return;
//   });
// });


// db.insert({ datatype: 'waterMachine', watermachineId: 'device0001', name: 'test001',longitude:'117.309036',latitude:'31.686125'}, (err, data) => {
//   if (err) {
//     console.log(err);
//   } else {
//     console.log(data); // { ok: true, id: 'rabbit', ...
//   }
// });
//
// db.insert({ datatype: 'waterMachine', watermachineId: 'device0002', name: 'test002',longitude:'117.371414',latitude:'31.752472'}, (err, data) => {
//   if (err) {
//     console.log(err);
//   } else {
//     console.log(data); // { ok: true, id: 'rabbit', ...
//   }
// });

// db.find({
//   selector: {
//     "waterId": "test001"
//   }
// }, function (err,body) {
//   if (err) {
//     console.log(err);
//   } else {
//     console.log(body); // { ok: true, id: 'rabbit', ...
//   }
// });

// db.list({waterId:'test001'}, function (error, body){
//   if (error) {
//     console.log(error);
//   } else {
//     console.log(data); // { ok: true, id: 'rabbit', ...
//   }
// });

// db.get("rabbit",function (err,body) {
//   if (!err){
//     console.log(body);
//   }else {
//     console.log(err);
//   }
// });
