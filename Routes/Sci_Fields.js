const express = require('express');
const scifieldsHandler = require('../handlers/Sci_Fields');

const router = express.Router();

// router.get('/', scifieldsHandler.getSciFields);
router.post('/delete/:id', scifieldsHandler.postDeleteSciFields);
router.post('/insert/:id', scifieldsHandler.postInsertSciFields);
router.post('/alter/:id', scifieldsHandler.postUpdateSciFields);

module.exports = router;