const { pool } = require('../utils/database');
exports.getPrograms = (req, res, next) => {
    /* Handler to retrieve Programs from database */
    
    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query('SELECT * FROM Elidek.Programs')
        .then(([rows, fields]) => {
            res.render('Programs.ejs', {
                pageTitle: "Elidek Programs",
                Programs: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}

/* Handler to delete program by ID from database */
exports.postDeleteProgram = (req, res, next) => {
    /* get id from params */
    const id = req.params.prog_id;
    
    /* create the connection, execute query, flash respective message and redirect to programs route */
    pool.getConnection((err, conn) => {
        var sqlQuery = `DELETE FROM Elidek.Programs WHERE prog_id = ${id}`;

        conn.promise().query(sqlQuery)
        .then(() => {
            pool.releaseConnection(conn);
            req.flash('messages', { type: 'success', value: "Successfully deleted grade!" })
            res.redirect('/programs');
        })
        .catch(err => {
            req.flash('messages', { type: 'error', value: "Something went wrong, Grade could not be deleted." })
            res.redirect('/programs');
        })
    })

}

/* Handler to insert program by to database */
exports.postInsertProgram = (req, res, next) => {
    /* get values from params */
    const id = req.params.prog_id;
    const name = req.params.Name;
    const department = req.params.Department;
    
    /* create the connection, execute query, flash respective message and redirect to programs route */
    pool.getConnection((err, conn) => {
        var sqlQuery = `DELETE FROM Elidek.Programs WHERE prog_id = ${id}`;

        conn.promise().query(sqlQuery)
        .then(() => {
            pool.releaseConnection(conn);
            req.flash('messages', { type: 'success', value: "Successfully deleted grade!" })
            res.redirect('/programs');
        })
        .catch(err => {
            req.flash('messages', { type: 'error', value: "Something went wrong, Grade could not be deleted." })
            res.redirect('/programs');
        })
    })

}