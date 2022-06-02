const express = require('express');
const indexHandler = require('../handlers/Index');

const router = express.Router();

router.get('/', indexController.getLanding);

module.exports = router;