// import dependencies and initialize the express router
const express = require('express');
const WaterController = require('../controllers/waterInfo-controller');

const router = express.Router();

// define routes
router.get('', WaterController.getWaterInfo);
router.post('/save', WaterController.saveWaterInfo);
module.exports = router;
