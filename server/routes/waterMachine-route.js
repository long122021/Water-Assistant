// import dependencies and initialize the express router
const express = require('express');
const WaterInfoController = require('../controllers/waterMachine-controller');

const router = express.Router();

// define routes
router.get('', WaterInfoController.getWaterMachine);
router.post('/save', WaterInfoController.saveWaterMachine);

module.exports = router;
