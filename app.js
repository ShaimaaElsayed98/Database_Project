var express = require("express");
var path = require("path");
const mysql=require('mysql')
var routes= require("./Routes/routes");
const { request } = require("http");
const console = require("console");
var app =  express();


/*Database connection through pool (not working)
/*const pool = mysql.createPool({
    connectionLimit : 100,
    host : process.env.DB_HOST,
    user : process.env_DB_USER,
    database : process.env.DB_NAME,
    port : process.env.DB_PORT
})*/


/*database connected*/
var connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "password",
    database: "elidek",
    port: "3306"
})

/*Not working
/*pool.getConnection((err, connection) => {
    if(err){
        throw err
    }
    else {
        console.log("connected")
    }
});*/

connection.connect((err) =>{
    if(err){
        throw err
    }
    else {
        console.log("database connected")
    }

})

/*Tested the connection, it works
connection.connect(function(err){
    if(err)throw err;
    connection.query("SELECT * from programs",function(err,result){
          if(err)throw err;
          console.log(result);

    })
})*/




/*connected through port 3000*/
app.set("port", process.env.PORT || 3000);
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.use(express.static(__dirname + '/public'));
app.use(routes);

app.listen(app.get("port"),function(){
    console.log("Server started on port " + app.get("port"));
});

