import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";
import { schema } from "../createSchema";
import { data } from "../populateDB";
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
        keepAlive: true
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

        let query: string = 'SELECT * FROM VETOSANSFRONTIERE.Clinic;';
        const queryresult = this.pool.query(query);
        this.pool.end;
        return queryresult;
    }

    public getClinicId(): Promise<pg.QueryResult> {
        this.pool.connect();
        console.log("getting clinic PKs");
        let query: string = 'SELECT cid FROM VETOSANSFRONTIERE.Clinic;';
        const queryresult = this.pool.query(query);
        this.pool.end;
        return queryresult;
    }

    public getOwnerFromParams(params: any): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string = 'SELECT * FROM VETOSANSFRONTIERE.Owner \n';
        const keys: string[] = Object.keys(params);
        console.log(keys);

        if (keys.length > 0) {
            query = query.concat(`WHERE ${keys[0]} =\'${params[keys[0]]}\'`);

            for (const param in keys) {
                const value: string = keys[param];
                query = query.concat(` AND ${value} = \'${params[value]}\'`);
                /*if (param === 'price') {
                    query = query.replace('\'', '');
                }*/
            }
        }
        query = query.concat(';');
        console.log(query);
        const queryresult = this.pool.query(query);

        this.pool.end;
        return queryresult;
    }

    public getTreatmentFromParams(params: any): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string = 'SELECT * FROM VETOSANSFRONTIERE.Treatment \n';
        const keys: string[] = Object.keys(params);
        console.log(keys);

        if (keys.length > 0) {
            query = query.concat(`WHERE ${keys[0]} =\'${params[keys[0]]}\'`);

            for (const param in keys) {
                const value: string = keys[param];
                query = query.concat(` AND ${value} = \'${params[value]}\'`);
            }
        }
        query = query.concat(';');
        console.log(query);
        const queryresult = this.pool.query(query);

        this.pool.end;
        return queryresult;
    }

    public updateOwner(params: any): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string = 'UPDATE VETOSANSFRONTIERE.Owner SET \n';
        let selector: string = `WHERE cid = \'${params.cid}\' AND ownerid = \'${params.ownerid}\'`
        const keys: string[] = Object.keys(params);
        console.log(keys);

        if (keys.length > 0) {
            // On enleve le premier et le deuxieme element
            keys.shift();
            keys.shift();
            keys.shift();
            for (const param in keys) {
                const value: string = keys[param];
                query = query.concat(` ${value} = \'${params[value]}\'`);
                if (value !== "address") {
                    query = query.concat(', \n')
                }
            }
        }
        query = query.concat(`${selector};`);
        console.log(query);
        const queryresult = this.pool.query(query);

        this.pool.end;
        return queryresult;
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
        const query: string = `INSERT INTO VETOSANSFRONTIERE.Owner VALUES($1,$2,$3,$4,$5);`;

        const queryresult = this.pool.query(query, values);
        this.pool.end;
        return queryresult;
    }

    // NEW PET
    public newPet(params: any): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string = `INSERT INTO VETOSANSFRONTIERE.Pet VALUES ( 
        \'${params.ownerid}\', 
        \'${params.cid}\',
        \'${params.petid}\',
        \'${params.name}\',
        \'${params.specie}\',
        \'${params.description}\',
        \'${params.dob}\',
        \'${params.status}\' );`;
        console.log(query);
        const queryresult = this.pool.query(query);

        this.pool.end;
        return queryresult;
    }

    // UPDATING PET
    public updatePet(params: any): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string = 'UPDATE VETOSANSFRONTIERE.Pet SET \n';
        var keys: string[] = Object.keys(params);
        console.log(keys);
        let selector: string = ` WHERE cid = \'${params.cid}\' AND ownerid = \'${params.ownerid}\' AND petid = \'${params.petid}\'`;
        

        if (keys.length > 0) {
            // On enleve le premier et le deuxieme element
            keys.shift();
            keys.shift();
            keys.shift();
            console.log(keys);
            
            for (const param in keys) {
                const value: string = keys[param];
                query = query.concat(` ${value} = \'${params[value]}\'`);
                if (value !== "status") {
                    query = query.concat(', \n')
                }
            }
        }
        query = query.concat(selector)
        query = query.concat(';');
        console.log(query);
        const queryresult = this.pool.query(query);

        this.pool.end;
        return queryresult;
    }


    // DELETING PET
    public deletePet(params: any): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string = 'DELETE FROM VETOSANSFRONTIERE.Pet \n';
        var keys: string[] = Object.keys(params);
        console.log(keys);
        let selector: string = ` WHERE cid = \'${params.cid}\' AND ownerid = \'${params.ownerid}\' AND petid = \'${params.petid}\'`;
        query = query.concat(selector)

        query = query.concat(';');
        console.log(query);
        const queryresult = this.pool.query(query);

        this.pool.end;
        return queryresult;
    }

    public getPetFromParams(params: any): any {
        this.pool.connect();
        let query: string = 'SELECT * FROM VETOSANSFRONTIERE.Pet \n';
        const keys: string[] = Object.keys(params);
        console.log(keys);

        if (keys.length > 0) {
            query = query.concat(`WHERE ${keys[0]} =\'${params[keys[0]]}\'`);

            // On enleve le premier element
            keys.shift();
            // tslint:disable-next-line:forin
            for (const param in keys) {
                const value: string = keys[param];
                query = query.concat(` AND ${value} = \'${params[value]}\'`);
            }
        }
        query = query.concat(';');
        console.log(query);
        const queryresult = this.pool.query(query);

        this.pool.end;
        return queryresult;
    }

    // Owner
    public getOwnerIdsFromClinic(clinicid: string): Promise<pg.QueryResult> {
        this.pool.connect();
        console.log(`Getting Owners PKs from \'${clinicid}\'`);
        let query: string =
            `SELECT ownerid FROM VETOSANSFRONTIERE.Owner
        WHERE cID=\'${clinicid}\';`

        console.log('query sent');
        console.log(query);
        

        const queryresult = this.pool.query(query);
        this.pool.end;
        return queryresult;
    }

    public getOwnerFromClinic(mrequest: object): Promise<pg.QueryResult> {
        this.pool.connect();
        let query: string =
            `SELECT * FROM VETOSANSFRONTIERE.Owner`
        const keys: string[] = Object.keys(mrequest);

        if (keys.length >= 1) {
            query = query.concat(`WHERE `);
            var counter = 0
            for (const key in mrequest) {
                if (mrequest.hasOwnProperty(key)) {
                    query = query.concat(`WHERE ${key} =\'${mrequest[key]}\` `);
                    if (keys.length >= 2 && counter < key.length) {
                        query = query.concat(`AND `);
                        counter += 1;
                    }

                }
            }
        }
        query = query.concat(';');
        console.log('query sent');
        console.log(query);
        const queryresult = this.pool.query(query);
        this.pool.end;
        return queryresult;
    }

    // Pets
    getPetsIdsFromOwnerClinic(clinicid: string, ownerid: string): Promise<pg.QueryResult> {
        this.pool.connect();
        console.log(`Getting Pets PKs from \'${clinicid}\', \'${ownerid}\'`);
        let query: string =
            `SELECT petid FROM VETOSANSFRONTIERE.Pet
        WHERE cID=\'${clinicid}\'
        AND ownerID=\'${ownerid}\';`
        const queryresult = this.pool.query(query);
        console.log('query sent');
        console.log(query);
        this.pool.end;
        return queryresult;
    }

    getExamsIdsFromOwnerClinicPet(clinicid: string, ownerid: string, petid: string): Promise<pg.QueryResult> {
        this.pool.connect();
        console.log(`Getting Pets PKs from \'${clinicid}\', \'${ownerid}\'`);
        let query: string =
            `SELECT examID FROM VETOSANSFRONTIERE.Physical_exam
        WHERE cID=\'${clinicid}\'
        AND ownerID=\'${ownerid}\'
        AND petID = \'${petid}\';`
        const queryresult = this.pool.query(query);
        console.log('query sent');
        console.log(query);
        this.pool.end;
        return queryresult;
    }

    getTreatsIdsFromOwnerClinicPetExam(examid: string): Promise<pg.QueryResult> {
        this.pool.connect();
        console.log(`Getting Treat PKs from \'${examid}\'`);
        let query: string =
            `SELECT treatID FROM VETOSANSFRONTIERE.treatment
        WHERE examID = \'${examid}\';`
        const queryresult = this.pool.query(query);
        console.log('query sent');
        console.log(query);
        this.pool.end;
        return queryresult;
    }

    

}
