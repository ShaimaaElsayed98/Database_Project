const express = require('express');
const orgHandler = require('../handlers/Org');

const router = express.Router();

// router.get('/', orgHandler.getOrg);
router.post('/delete/:id', orgHandler.postDeleteOrg);
router.post('/insert/:id', orgHandler.postInsertOrg);
router.post('/alter/:id', orgHandler.postUpdateOrg);

module.exports = router;