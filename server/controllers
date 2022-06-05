const express = require('express');
const mysql = require('mysql2');
const router = require('../routes/ques3');

//Connection Pool
const pool = mysql.createPool({
    connectionLimit: 100,
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT
});


exports.getResearchers = async function (req, res, next) {
    const q1 = 'SELECT Researcher_id, Projects_per_Researcher, Name as researcher_Name FROM Projects_Per_Researcher';
    const q2 = 'SELECT * FROM Gender_of_Researchers;';
    const q3 = `SELECT SF.Name as sf_name, PSF.Title, RPP2.Name, RPP2.Last_Name 
    FROM Scientific_Fields AS SF 
        RIGHT JOIN (SELECT P.Title,P.Project_id,SFP.sci_id FROM Projects AS P LEFT JOIN Scientific_Fields_of_Project AS SFP ON P.Project_id = SFP.Project_id WHERE P.Ending_Date > NOW()) AS PSF ON SF.sci_id = PSF.sci_id
        LEFT JOIN (SELECT R.Name, R.Last_Name, RPP.sci_id FROM Researchers AS R RIGHT JOIN (SELECT WIP.Researcher_id, SFOP.Project_id, SFOP.sci_id FROM works_in_proj AS WIP JOIN Scientific_Fields_of_Project AS SFOP ON WIP.proj_id = SFOP.Project_id) AS RPP ON R.Researcher_id = RPP.Researcher_id) AS RPP2 ON RPP2.sci_id = SF.sci_id 
    WHERE SF.Name = 'Computer Science';`;
    const q4 = `SELECT SEL1.Org_id, SEL1.Name, SEL1.Abbreviation, SEL1.COUNT1 +SEL2.COUNT2 AS TOTAL_PROJECTS_IN_2_Y
    FROM ( 
        SELECT * FROM
        (SELECT O.Org_id, O.Name, O.Abbreviation, count(*) AS COUNT1 FROM Organization AS O
            INNER JOIN Projects AS P ON O.Org_id = P.org_mgmt 
        WHERE (P.Starting_Date > DATE_SUB(NOW(),INTERVAL 1 YEAR) AND P.Starting_Date < NOW())
        GROUP BY O.Org_id) AS TOT1
        WHERE TOT1.COUNT1 > 10) AS SEL1
    INNER JOIN
        (SELECT * FROM
        (SELECT O.Org_id, O.Name, O.Abbreviation, count(*) AS COUNT2 FROM Organization AS O
            INNER JOIN Projects AS P ON O.Org_id = P.org_mgmt 
        WHERE (P.Starting_Date > DATE_SUB(NOW(),INTERVAL 2 YEAR) AND P.Starting_Date < DATE_SUB(NOW(),INTERVAL 1 YEAR))
        GROUP BY O.Org_id) AS TOT2
        WHERE TOT2.COUNT2 > 10) AS SEL2
    ON
        SEL1.Org_id = SEL2.Org_id
    WHERE 
        SEL1.COUNT1 >10 AND SEL2.COUNT2 > 10;`;
    const q5 = `SELECT S1.sci_id as sci_id_1 ,S2.sci_id as sci_id_2, COUNT(*) AS occurence
    FROM (SELECT S.sci_id, P.Project_id, P.Title  
        FROM Projects AS P 
            INNER JOIN
        Scientific_Fields_of_Project AS S 
        ON P.Project_id = S.Project_id) AS S1
    JOIN 
        (SELECT S.sci_id, P.Project_id, P.Title 
        FROM Projects AS P 
            INNER JOIN
        Scientific_Fields_of_Project AS S 
        ON P.Project_id = S.Project_id) AS S2
    ON S1.Project_id = S2.Project_id
    WHERE S1.sci_id > S2.sci_id
    GROUP BY S1.sci_id, S2.sci_id
    ORDER BY occurence DESC LIMIT 3;`;
    const q6 = `SELECT R1.Researcher_id, R1.Name, R1.Last_name, COUNT(*) AS projects
    FROM (SELECT R.Researcher_id, R.Name, R.Last_name, R.Date_of_Birth, WIP.proj_id 
        FROM Researchers AS R
            INNER JOIN
        works_in_proj AS WIP
        ON R.Researcher_id = WIP.Researcher_id
    WHERE DATE_SUB(NOW(), INTERVAL 40 YEAR) < R.Date_of_Birth) AS R1
    GROUP BY R1.Researcher_id
    ORDER BY projects DESC;`;
    const q7 = `SELECT 
    E.exec_id, 
    E.First_Name, 
    E.Last_Name,
    C.org_id,
    O.Name, 
    SUM(Funding) AS funding
    FROM Executives AS E
    INNER JOIN
    Projects AS P
    ON E.exec_id = P.exec_id
    JOIN Organization AS O 
      ON O.Org_id = P.org_mgmt 
    JOIN Corporation AS C 
      ON C.org_id  = P.org_mgmt
    GROUP BY E.exec_id,C.org_id 
    ORDER BY funding DESC LIMIT 5;`;
    const q8 = `SELECT 
    R.Researcher_id ,
    R.Name ,
    R.Last_Name
    FROM Researchers AS R
    JOIN works_in_proj AS WIP
    ON R.Researcher_id = WIP.Researcher_id 
    JOIN Projects AS P 
     ON WIP.proj_id = P.Project_id 
    JOIN Deliverable_Projects AS DP 
     ON DP.Project_id = P.Project_id
    WHERE P.Project_id NOT IN (DP.Project_id);`;


    const queries = {
        '3.2.1': q1,
        '3.2.2': q2,
        '3.3': q3,
        '3.4': q4,
        '3.5': q5,
        '3.6': q6,
        '3.7': q7,
        '3.8': q8
    }
    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection(async function (err, conn) {
        const result = await runQueries(conn, queries);
        res.render('home.ejs', {
            title: "question 3.2",
            Researchers: result[0],
            data: result,
            messages: messages
        })
        pool.releaseConnection(conn)
    })

}

async function runQueries(conn, queries) {
    const keys = Object.keys(queries);
    let result = {};
    for (let i = 0; i < keys.length; i++) {
        const key = keys[i];
        const query = queries[key];
        const rows = await getRows(conn, query);
        result[key] = rows;
    }
    return result;
}

async function getRows(conn, query) {
    const [rows] = await conn.promise().query(query);
    return rows;
}
