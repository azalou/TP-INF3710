const express = require('express');
const db = require('./queries')
const PORT = process.env.PORT || 3000;

const app = express();
const mnt = require('moment');
const path = require('path');
const logger = (req, resp, next) => {
	console.log(`${mnt().format()}: ${req.protocol}://${req.get('host')}${req.originalUrl}`);
	next();
};

//init middleware
app.use(logger);

// set static folder
app.use(express.static(path.join(__dirname, 'VetoSF')));
app.get('/', (req, res) => {
	res.sendFile(path.join(__dirname, 'VetoSF', 'VetoSF.html'))
});

// get list of members
app.get('/members', db.getOwners);
app.get('/members/:id', db.getOwnerByID)

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));

