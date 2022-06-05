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

app.use(express.urlencoded({ extended: true }));
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
    connectionLimit: 100,
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT
});

//connect to DB
pool.getConnection((err, connection) => {
    if (err) throw err; //not connected
    console.log('database connected');
});

const routes = require('./server/routes/ques3');
app.use('/', routes);


app.get("/Programs", function(req,res){
    res.render("Programs")
});

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");


app.listen(port, () => console.log(`Listening on port ${port}`));


module.exports = app;
