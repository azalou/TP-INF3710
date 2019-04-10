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

const getClinics = (request, response) => {
    pool.query('SELECT * FROM vetosansfrontiere.clinic', (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
        
    }) 
}
const getOwnerBycID = (request, response) => {
    const id = request.params.id
    pool.query('SELECT * FROM vetosansfrontiere.owner WHERE cID = $1', [id], (error, results) => {
        if (!results) {
            response.status(400).json({msg: `Owner with id ${id} does not exist`})
		//there is a bug with http 400 status:
            }
            response.status(200).json(results.rows)
    })
}

const saveOwners = (request, response) => {
    console.log("updating owner table")
    response.end()
}

module.exports = {
    getOwners,
    getOwnerBycID,
    saveOwners,
    getClinics,
}
