const express = require("express");
const path = require("path");
const session = require('express-session');

/* Routes imports */
const index = require('./Routes/index.js'); 
const Exec = require('./Routes/Exec.js'); 
const Org = require('./Routes/Org.js'); 
const programs = require('./Routes/programs.js'); 
const Proj = require('./Routes/Proj.js'); 
const Researchers = require('./Routes/Researchers.js'); 
const Sci_Fields = require('./Routes/Sci_Fields.js'); 

/* End of Routes imports */
var app =  express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


/*connected through port 3000*/
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');
app.set('views', 'views');

app.use(flash());

app.use(session({
    secret: "ThisShouldBeSecret",
    resave: false,
    saveUninitialized: false
}));

/* All the routes used by the program */

app.use('/', index);
app.use('/executives', Exec);
app.use('/organizations', Org);
app.use('/programs', programs);
app.use('/projects', Proj);
app.use('/researchers', Researchers);
app.use('/scientific_fields', Sci_Fields);

/* End of routes used */

module.exports = app;