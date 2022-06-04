const express = require('express');
const mysql = require('mysql2');
const router = require('../routes/ques3');

//Connection Pool
const pool = mysql.createPool({
    connectionLimit : 100,
    host            : process.env.DB_HOST,
    user            : process.env.DB_USER,
    password        : process.env.DB_PASS,   
    database        : process.env.DB_NAME,
    port            : process.env.DB_PORT 
});


exports.getResearchers = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query('SELECT * FROM Researchers')
        .then(([rows, fields]) => {
            res.render('ques3.ejs', {
                title:"question 3.2",
                Researchers: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}; 
