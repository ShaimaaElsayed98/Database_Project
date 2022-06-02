const mysql = require('mysql2');

/* create connection and export it */
const pool = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "Boom_kaboom12365",
    database: "Elidek",
    port: "3306"
});

module.exports = { pool };