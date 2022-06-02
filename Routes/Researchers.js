const express = require('express');
const researcherHandler = require('../handlers/Researchers');

const router = express.Router();

// router.get('/', researcherHandler.getResearchers);
router.post('/delete/:id', researcherHandler.postDeleteResearchers);
router.post('/insert/:id', researcherHandler.postInsertResearchers);
router.post('/alter/:id', researcherHandler.postUpdateResearchers);

module.exports = router;