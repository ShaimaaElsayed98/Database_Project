const express = require('express');
const router = express.Router();
const ques3Controller = require('../controllers/ques3Controller');


//create, find, update, delete
router.get('/', ques3Controller.getResearchers);


module.exports = router;
