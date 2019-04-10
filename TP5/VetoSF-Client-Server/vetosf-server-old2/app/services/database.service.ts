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
        console.log("are we here???");
        
        return this.pool.query('SELECT * FROM VETOSANSFRONTIERE.Clinic;');
    }

    public getClinicId(): Promise<pg.QueryResult> {
        this.pool.connect();

        return this.pool.query('SELECT cID FROM VETOSANSFRONTIERE.Clinic;');
    }

    /*public createClinic(hotelId: string, hotelName: string, city: string): Promise<pg.QueryResult> {
        this.pool.connect();
        const values: string[] = [
            hotelId,
            hotelName,
            city
        ];
        const queryText: string = `INSERT INTO VETOSANSFRONTIERE.Clinic VALUES($1, $2, $3);`;

        return this.pool.query(queryText, values);
    }*/

    // Owner
    public getOwnerFromClinic(cID: string, name: string): Promise<pg.QueryResult> {
        this.pool.connect();

        let query: string =
        `SELECT * FROM VETOSANSFRONTIERE.Owner
        WHERE cID=\'${cID}\'`;
        if (name !== undefined) {
            query = query.concat('AND ');
            query = query.concat(`typeOwner=\'${name}\'`);
        }
        console.log(query);

        return this.pool.query(query);
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

    public createOwner(Owner: Owner): Promise<pg.QueryResult> {
        this.pool.connect();
        const values: string[] = [
            Owner.ownerID,
            Owner.cID,
            Owner.name,
            Owner.phone,
            Owner.address
        ];
        const queryText: string = `INSERT INTO VETOSANSFRONTIERE.Owner VALUES($1,$2,$3,$4,$5);`;

        return this.pool.query(queryText, values);
    }

    // GUEST
    /*public createGuest(guestId: string,
                       nas: string,
                       guestName: string,
                       gender: string,
                       guestCity: string): Promise<pg.QueryResult> {
        this.pool.connect();
        const values: string[] = [
            guestId,
            nas,
            guestName,
            gender,
            guestCity
        ];
        const queryText: string = `INSERT INTO VETOSANSFRONTIERE.Owner VALUES($1,$2,$3,$4,$5);`;

        return this.pool.query(queryText, values);
    }

    // BOOKING
    public createBooking(hotelId: string,
                         guestId: string,
                         dateFrom: Date,
                         dateTo: Date,
                         OwnerId: string): Promise<pg.QueryResult> {
        this.pool.connect();
        const values: string[] = [
            hotelId,
            guestId,
            dateFrom.toString(),
            dateTo.toString(),
            OwnerId
        ];
        const queryText: string = `INSERT INTO VETOSANSFRONTIERE.Owner VALUES($1,$2,$3,$4,$5);`;

        return this.pool.query(queryText, values);
        }*/
}
