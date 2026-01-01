const express = require('express');
const router = express.Router();
const User = require('../models/User');

// 1. LOGIN ROUTE
router.post('/login', async (req, res) => {
    console.log("🔹 Login Attempt:", req.body.email); // Log for debugging

    try {
        const { email, password } = req.body;
        
        // Find user
        const user = await User.findOne({ email });
        if (!user) {
            console.log("❌ User not found");
            return res.status(404).json({ message: "User not found. Please Sign Up!" });
        }

        // Check password
        if (user.password !== password) {
            console.log("❌ Wrong password");
            return res.status(401).json({ message: "Invalid password" });
        }

        // Success
        console.log("✅ Login Successful for:", user.username);
        res.status(200).json({ 
            message: "Login Successful", 
            username: user.username 
        });

    } catch (error) {
        console.error("❌ Login Server Error:", error);
        res.status(500).json({ message: "Server Error", error: error.message });
    }
});

// 2. SIGNUP ROUTE
router.post('/signup', async (req, res) => {
    console.log("🔹 Signup Attempt:", req.body); // Log the incoming data

    try {
        const { username, email, password } = req.body;

        // Validation: Ensure no empty fields
        if (!username || !email || !password) {
            return res.status(400).json({ message: "Please fill in all fields" });
        }

        // Check if user already exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            console.log("❌ User already exists:", email);
            return res.status(400).json({ message: "User already exists" });
        }

        // Create new user
        const newUser = new User({ username, email, password });
        await newUser.save();

        console.log("✅ User Created:", username);
        res.status(201).json({ message: "User created successfully!" });

    } catch (error) {
        console.error("❌ Signup Error:", error);
        res.status(500).json({ message: "Error creating user", error: error.message });
    }
});

// 3. MAGIC TEST ROUTE (Keep this for now, it's useful!)
router.get('/create-test-user', async (req, res) => {
    try {
        const email = "fedi.hajtaieb@supcom.tn";
        const password = "password123";
        
        let user = await User.findOne({ email });
        if (!user) {
            user = new User({ username: "Fedi", email, password });
            await user.save();
            return res.send(`<h1>✅ User Created!</h1><p>${email}</p>`);
        }
        res.send(`<h1>⚠️ User Already Exists</h1><p>${email}</p>`);
    } catch (e) {
        res.send(e.message);
    }
});

module.exports = router;