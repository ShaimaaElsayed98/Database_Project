var express = require("express");
var router = express.Router();

router.get("/", function(req,res){
    res.render("index")
});

router.get("/Programs", function(req,res){
    res.render("Programs")
});

router.get("/Proj", function(req,res){
    res.render("Proj")
});

router.get("/Exec", function(req,res){
    res.render("Exec")
});

router.get("/Org", function(req,res){
    res.render("Org")
});

router.get("/Researchers", function(req,res){
    res.render("Researchers")
});

router.get("/Sci_Fields", function(req,res){
    res.render("Sci_Fields")
});

module.exports = router;