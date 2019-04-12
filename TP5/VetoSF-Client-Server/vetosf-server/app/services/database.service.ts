import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";
import {schema} from "../createSchema";
import {data} from "../populateDB";
import { Owner } from "../../../common/tables";

@injectable()
export class DatabaseService {

    // A MODIFIER POUR VOTRE BD
    public connectionConfig: pg.ConnectionConfig = {
        user: "azalou",
        database: "vetosf",
        password: "12345",
        port: 5432,
        host: "127.0.0.1",
        keepAlive : true
    };

    private pool: pg.Pool = new pg.Pool(this.connectionConfig);

    /*
        METHODES DE DEBUG
    */
    public createSchema(): Promise<pg.QueryResult> {
        this.pool.connect();
        
        return this.pool.query(schema);
    }

    public populateDb(): Promise<pg.QueryResult> {
        this.pool.connect();

        return this.pool.query(data);
    }

    public getAllFromTable(tableName: string): Promise<pg.QueryResult> {
        this.pool.connect();
        return this.pool.query(`SELECT * FROM VETOSANSFRONTIERE.${tableName};`);
    }

    // CLINIC
    public getClinics(): Promise<pg.QueryResult> {
        this.pool.connect();
                
        return this.pool.query('SELECT * FROM VETOSANSFRONTIERE.Owner;');
    }

    public getClinicId(): Promise<pg.QueryResult> {
        this.pool.connect();
        console.log("getting clinic PKs");
        return this.pool.query('SELECT cid FROM VETOSANSFRONTIERE.Clinic;');
    }

    public getOwnerFromClinicParams(params: object): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string = 'SELECT * FROM VETOSANSFRONTIERE.Owner \n';
        const keys: string[] = Object.keys(params);
        if (keys.length > 0) {
            query = query.concat(`WHERE ${keys[0]} =\'${params[keys[0]]}\'`);
        }
        // On enleve le premier element
        keys.shift();
        // tslint:disable-next-line:forin
        for (const param in keys) {
            const value: string = keys[param];
            query = query.concat(`AND ${value} = \'${params[value]}\'`);
            if (param === 'price') {
                query = query.replace('\'', '');
            }
        }
        console.log(query);
        return this.pool.query(query);
    }

    // Owner
    public getOwnerFromClinic(cID: string, oID: string): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string =
        `SELECT * FROM VETOSANSFRONTIERE.Owner
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
    public getOwnerIdsFromClinic(clinicid: string): Promise<pg.QueryResult> {
        this.pool.connect();
        console.log(`Getting Owners PKs from \'${clinicid}\'`);
        
        let query: string = 
        `SELECT ownerid FROM VETOSANSFRONTIERE.Owner
        WHERE cID=\'${clinicid}\'`

        return this.pool.query(query);
    }

    public createOwner(Owner: Owner): Promise<pg.QueryResult> {
        this.pool.connect();
        const values: string[] = [
            Owner.ownerid,
            Owner.cid,
            Owner.name,
            Owner.phone,
            Owner.address
        ];
        const queryText: string = `INSERT INTO VETOSANSFRONTIERE.Owner VALUES($1,$2,$3,$4,$5);`;

        return this.pool.query(queryText, values);
    }

}
