'use strict';

const mongoose = require('mongoose');
require('dotenv').config({silent: true, path: `${__dirname}/.env`});

var server = require('./app');
var port = 3400;

console.log(`Running on ${process.env.BASE_PATH}:${port}, connecting to ${process.env.MONGO_URL}`)

mongoose.connect(process.env.MONGO_URL, { useNewUrlParser: true, useUnifiedTopology: true }).then(
    () => {
        server.listen(port, function(){
            console.log("Server running on port: %d", port)
        })
    },
    err => {
        console.log(err)
    }
);