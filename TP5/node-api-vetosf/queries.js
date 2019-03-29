const Pool = require('pg').Pool


const pool = new Pool({
  user: 'azalou',
  host: 'localhost',
  database: 'TP5',
  password: 'inf3710',
  port: 5432,
})

