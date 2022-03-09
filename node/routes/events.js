const express = require('express')
const router = express.Router();
const Event = require('../model/Event')

//GetAll
router.get('/', async (req, res) => {
    try {
        const events = await Event.find();
        res.status(200).json(events);
    } catch (err) {
        res.status(400).json({ message: err });
    }
});
//GetByID
router.get('/:id', async (req, res) => {
    try {
        const event = await Event.findById(req.params.id);
        res.status(200).json(event);
    } catch (err) {
        res.status(400).json({ message: err });
    }
});

//Create
router.post('/', async (req, res) => {
    const event = new Event({
        title: req.body.title,
        description: req.body.description,
    })
    try {
        const savedPost = await event.save();
        res.status(200).json(savedPost);
    } catch (err) {
        res.status(400).json({ message: err });
    }

});

//Update
router.patch('/', async (req, res) => {
    try {
        const updateResult = await Event.updateOne({
            "_id": req.body._id
        }, { $set: req.body });
        res.status(200).json(updateResult);
    } catch (err) {
        res.status(400).json({ message: err });
    }
});

//Delete
router.delete('/:id', async (req, res) => {
    try {
        const event = await Event.deleteOne({
            "_id": req.params.id
        });
        res.status(200).json(event);
    } catch (err) {
        res.status(400).json({ message: err });
    }

});

module.exports = router;