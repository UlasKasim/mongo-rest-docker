const mongoose = require('mongoose');

const EventSchema = mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: String,
});

module.exports = mongoose.model('Events', EventSchema)