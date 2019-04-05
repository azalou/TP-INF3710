const Pool = require('pg').Pool
const pool = new Pool({
	user: 'azalou',
	host: 'localhost',
    database: 'vetosf',
	password: '12345',
	port: 5432,
})

const getOwners = (request, response) => {
    pool.query('SELECT * FROM vetosansfrontiere.owner ORDER BY cid ASC', (error, results) => {
        if (error) {
        throw error
        }
        response.status(200).json(results.rows)
    })
}
const getOwnerByID = (request, response) => {
    const id = request.params.id
    pool.query('SELECT * FROM vetosansfrontiere.owner WHERE ownerID = $1', [id], (error, results) => {
        if (error) {
            throw error
            }
            response.status(200).json(results.rows)
    })
}
module.exports = {
    getOwners,
    getOwnerByID,
  }