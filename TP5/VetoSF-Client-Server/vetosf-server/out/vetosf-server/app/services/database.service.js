"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
const inversify_1 = require("inversify");
const pg = require("pg");
require("reflect-metadata");
const createSchema_1 = require("../createSchema");
const populateDB_1 = require("../populateDB");
let DatabaseService = class DatabaseService {
    constructor() {
        // A MODIFIER POUR VOTRE BD
        this.connectionConfig = {
            user: "azalou",
            database: "vetosf",
            password: "12345",
            port: 5432,
            host: "127.0.0.1",
            keepAlive: true
        };
        this.pool = new pg.Pool(this.connectionConfig);
    }
    /*
        METHODES DE DEBUG
    */
    createSchema() {
        this.pool.connect();
        return this.pool.query(createSchema_1.schema);
    }
    populateDb() {
        this.pool.connect();
        return this.pool.query(populateDB_1.data);
    }
    getAllFromTable(tableName) {
        this.pool.connect();
        return this.pool.query(`SELECT * FROM VETOSANSFRONTIERE.${tableName};`);
    }
    // CLINIC
    getClinics() {
        this.pool.connect();
        return this.pool.query('SELECT * FROM VETOSANSFRONTIERE.Owner;');
    }
    getClinicId() {
        this.pool.connect();
        console.log("getting clinic PKs");
        return this.pool.query('SELECT cid FROM VETOSANSFRONTIERE.Clinic;');
    }
    getOwnerFromClinicParams(params) {
        this.pool.connect();
        let query = 'SELECT * FROM VETOSANSFRONTIERE.Owner \n';
        const keys = Object.keys(params);
        if (keys.length > 0) {
            query = query.concat(`WHERE ${keys[0]} =\'${params[keys[0]]}\'`);
        }
        // On enleve le premier element
        keys.shift();
        // tslint:disable-next-line:forin
        for (const param in keys) {
            const value = keys[param];
            query = query.concat(`AND ${value} = \'${params[value]}\'`);
            if (param === 'price') {
                query = query.replace('\'', '');
            }
        }
        console.log(query);
        return this.pool.query(query);
    }
    // Owner
    getOwnerFromClinic(cID, oID) {
        this.pool.connect();
        let query = `SELECT * FROM VETOSANSFRONTIERE.Owner
        WHERE cID=\'${cID}\'`;
        if (oID !== undefined) {
            query = query.concat(`AND ownerid=\'${oID}\'`);
        }
        console.log(query);
        return this.pool.query(query);
    }
    /**
     * getOwnerIdsFromClinic
clinicid: string : Promise<pg.QueryResults>    */
    getOwnerIdsFromClinic(clinicid) {
        this.pool.connect();
        console.log(`Getting Owners PKs from \'${clinicid}\'`);
        let query = `SELECT ownerid FROM VETOSANSFRONTIERE.Owner
        WHERE cID=\'${clinicid}\'`;
        return this.pool.query(query);
    }
    createOwner(Owner) {
        this.pool.connect();
        const values = [
            Owner.ownerid,
            Owner.cid,
            Owner.name,
            Owner.phone,
            Owner.address
        ];
        const queryText = `INSERT INTO VETOSANSFRONTIERE.Owner VALUES($1,$2,$3,$4,$5);`;
        return this.pool.query(queryText, values);
    }
};
DatabaseService = __decorate([
    inversify_1.injectable()
], DatabaseService);
exports.DatabaseService = DatabaseService;
//# sourceMappingURL=database.service.js.map