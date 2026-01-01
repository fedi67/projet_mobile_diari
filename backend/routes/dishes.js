const router = require('express').Router();
const Dish = require('../models/Dish');

// GET ALL DISHES
router.get('/', async (req, res) => {
  try {
    // Populate cook details (name, avatar) to show on the card
    const dishes = await Dish.find().populate('cook', 'username avatarUrl');
    res.status(200).json(dishes);
  } catch (err) {
    res.status(500).json(err);
  }
});

// CREATE DISH (For testing mainly)
router.post('/', async (req, res) => {
  const newDish = new Dish(req.body);
  try {
    const savedDish = await newDish.save();
    res.status(200).json(savedDish);
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;