const express = require('express');
const projHandler = require('../handlers/Proj');

const router = express.Router();

// router.get('/', projHandler.getProj);
router.post('/delete/:id', projHandler.postDeleteProj);
router.post('/insert/:id', projHandler.postInsertProj);
router.post('/alter/:id', projHandler.postUpdateProj);

module.exports = router;