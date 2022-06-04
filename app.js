const express = require('express');
const exphbs = require('express-handlebars');
var bodyParser = require('body-parser');
const flash = require('connect-flash');
const session = require('express-session');
const path = require('path');
const mysql = require('mysql2');
const req = require('express/lib/request');



require('dotenv').config();


const app = express();
const port = process.env.PORT || 5000;

app.use(express.urlencoded({extended: true}));
app.use(express.json());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


app.use(flash());
app.use(session({
    secret: "ThisShouldBeSecret",
    resave: false,
    saveUninitialized: false
}));

//static files
app.use(express.static(path.join(__dirname, '/public')));

//Templating Engine
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");


//Connection Pool
const pool = mysql.createPool({
    connectionLimit : 100, 
    host            : process.env.DB_HOST,
    user            : process.env.DB_USER,
    password        : process.env.DB_PASS,   
    database        : process.env.DB_NAME,
    port            : process.env.DB_PORT 
});

//connect to DB
pool.getConnection((err, connection) =>{
    if(err) throw err; //not connected
    console.log('database connected');
});


app.get("/", function(req,res){
    res.render("home")
});

app.get('/ques3', function(req,res){
    res.render('ques3')
});

const ques3 = require('./server/routes/ques3');
app.use('ques3',ques3);






app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");


app.listen(port,() => console.log(`Listening on port ${port}`));


module.exports= app;



/*connected through port 3000*/
app.set("port", process.env.PORT || 3000);
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.use(express.static(__dirname + '/public'));
app.use(routes);

app.listen(app.get("port"),function(){
    console.log("Server started on port " + app.get("port"));
});

