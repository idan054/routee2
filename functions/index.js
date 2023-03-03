
// To add library:
// $cd/functions/node_modules && npm i axios
// RUN THE CODE AT https://playcode.io/1249705
// My Firestore sample request server: https://github.com/idan054/FireBase_Fuctions_API/blob/master/functions/index.js
// How I Made it: https://www.youtube.com/watch?v=iIVlRZIo2-c&t=591s

//! Actually not in used in this project!

//import * as cors from 'cors';
const functions = require("firebase-functions");
const { default: axios } = require('axios');
//const axios = require('axios');
const corsHandler = require('cors')({origin: true});


 exports.serverVer = functions.https.onRequest((req, res) => {
        res.send({'SERVER VER:' : 2});
 });

 exports.autocomplete = functions.https.onRequest((req, res) => {
       //etc. example.com/user/000000?sex=female
       // ORIGINAL KEY: AIzaSyCzo0DzVe0YEMjpPUVMOGX3rqTtKEXlS9g
       const query = req.query;// query = {sex:"female"}
       const input = query["input"]

    corsHandler(req, res, () => {
       var url = `https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyD-5oNLyCX9tiICMNCozzSH8ZoUbb_-7pg&language=he&il&input=${input}`;
              axios.get(url, {}, {headers: {'Access-Control-Allow-Origin': '*'}})
           .then(function (response) {
               res.send(response.data);
           })
           .catch(function (error) {
               console.log(error);
           });
      });
 });

  exports.placeDetails = functions.https.onRequest((req, res) => {
    //etc. example.com/user/000000?sex=female
    const query = req.query;// query = {sex:"female"}
    const placeId = query["placeId"]
    corsHandler(req, res, () => {
        var url = `https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyD-5oNLyCX9tiICMNCozzSH8ZoUbb_-7pg&language=he&il&placeid=${placeId}`;
            axios.get(url, {}, {headers: {'Access-Control-Allow-Origin': '*'}})
            .then(function (response) {
                res.send(response.data);
            })
            .catch(function (error) {
                console.log(error);
            });
        });
  });
