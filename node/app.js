const express = require('express')
const app = express();
const mongoose = require('mongoose')
const bodyParser = require('body-parser');
require('dotenv/config')

app.use(bodyParser.json());

//Import Routes
const eventsRoute = require('./routes/events')

app.use('/events', eventsRoute)

//Start mongodb - Need to hide .env before git push, since this is example it is OK
mongoose.connect(process.env.DB_CONNECTION, { useNewUrlParser: true }, () => {
    console.log("Connected to DB");
})

app.listen(8080);