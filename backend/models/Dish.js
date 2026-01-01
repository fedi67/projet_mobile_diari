const mongoose = require('mongoose');

const DishSchema = new mongoose.Schema({
  name: { type: String, required: true },
  price: { type: String, required: true }, // e.g. "15.00 TND"
  description: { type: String },
  imageUrl: { type: String, required: true },
  category: { type: String, required: true }, // e.g. 'Couscous', 'Sweets'
  cook: { 
    type: mongoose.Schema.Types.ObjectId, 
    ref: 'User',
    required: true 
  },
  rating: { type: Number, default: 0 },
  location: { type: String, required: true },
}, { timestamps: true });

module.exports = mongoose.model('Dish', DishSchema);