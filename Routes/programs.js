const express = require('express');
const progHandler = require('../handlers/programs');

const router = express.Router();

router.get('/', progHandler.getPrograms);
router.post('/delete/:id', progHandler.postDeletePrograms);
router.post('/insert/:id', progHandler.postInsertPrograms);
router.post('/alter/:id', progHandler.postUpdatePrograms);

module.exports = router;