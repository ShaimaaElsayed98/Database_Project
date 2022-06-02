const express = require('express');
const execHandler = require('../handlers/Exec');

const router = express.Router();

// router.get('/', execHandler.getExec);
router.post('/delete/:id', execHandler.postDeleteExec);
router.post('/insert/:id', execHandler.postInsertExec);
router.post('/alter/:id', execHandler.postUpdateExec);

module.exports = router;