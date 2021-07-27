// import dependencies and initialize the express router
const express = require('express');
const WaterInfoDetail = require('../controllers/waterInfoDetail-controller');

const router = express.Router();

// define routes
router.get('', WaterInfoDetail.getWaterInfoDetail);
router.post('/save', WaterInfoDetail.saveWaterInfoDetail);

module.exports = router;