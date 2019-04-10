import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import * as pg from "pg";

import { DatabaseService } from "../services/database.service";
import Types from "../types";
import { Clinic, Owner } from "../../../common/tables";

@injectable()
export class DatabaseController {
    public constructor(@inject(Types.DatabaseService) private databaseService: DatabaseService) { }

    public get router(): Router {
        const router: Router = Router();

        router.post("/createSchema",
                    (req: Request, res: Response, next: NextFunction) => {
                    this.databaseService.createSchema().then((result: pg.QueryResult) => {
                        console.log("CECI EST UNE FONCTION DE TEST SEULEMENT");
                        res.json(result);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
                });

        router.post("/populateDb",
                    (req: Request, res: Response, next: NextFunction) => {
                    this.databaseService.populateDb().then((result: pg.QueryResult) => {
                        console.log("CECI EST UNE FONCTION DE TEST SEULEMENT");
                        res.json(result);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
        });

        router.get("/clinics",
                   (req: Request, res: Response, next: NextFunction) => {
                       
                    // Send the request to the service and send the response
                    this.databaseService.getClinics().then((result: pg.QueryResult) => {
                    const clinics: Clinic[] = result.rows.map((cli: any) => (
                        {
                            cid: cli.cid,
                            phone: cli.phone,
                            fax: cli.fax,
                            road: cli.road,
                            city: cli.city,
                            province: cli.province,
                            pcode: cli.pcode
                    }));
                    
                    res.json(clinics);
                }).catch((e: Error) => {
                    console.error(e.stack);
                });
            });

        router.get("/clinics/clinicids",
                   (req: Request, res: Response, next: NextFunction) => {
                      this.databaseService.getClinicId().then((result: pg.QueryResult) => {
                        const clinicPKs: string[] = result.rows.map((row: any) => row.cid);
                        res.json(clinicPKs);
                      }).catch((e: Error) => {
                        console.error(e.stack);
                    });
                  });

        /*router.post("/clinic/insert",
                    (req: Request, res: Response, next: NextFunction) => {
                        const clinicid: string = req.body.clinicid;
                        const clinicName: string = req.body.clinicName;
                        const city: string = req.body.city;
                        this.databaseService.createClinic(clinicid, clinicName, city).then((result: pg.QueryResult) => {
                        res.json(result.rowCount);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                        res.json(-1);
                    });
        });*/

        router.get("/owner",
                   (req: Request, res: Response, next: NextFunction) => {
                    // this.databaseService.getRoomFromClinic(req.query.clinicid, req.query.ownerType, req.query.price)
                    console.log("getting Owners")
                    this.databaseService.getOwnerFromClinicParams(req.query)
                    .then((result: pg.QueryResult) => {
                        const owner: Owner[] = result.rows.map((owner: Owner) => (
                            {
                                ownerid: owner.ownerid,
                                cid: owner.cid,
                                name: owner.name,
                                phone: owner.phone,
                                address: owner.address
                        }));
                        res.json(owner);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
            });

        router.post("/owner/insert",
                    (req: Request, res: Response, next: NextFunction) => {
                    const owner: Owner = {
                        ownerid: req.body.ownerid,
                        cid: req.body.cid,
                        name: req.body.name,
                        phone: req.body.phone,
                        address: req.body.address};
                    console.log(owner);

                    this.databaseService.createOwner(owner)
                    .then((result: pg.QueryResult) => {
                        res.json(result.rowCount);
                    })
                    .catch((e: Error) => {
                        console.error(e.stack);
                        res.json(-1);
                    });
        });

        router.get("/tables/:tableName",
                   (req: Request, res: Response, next: NextFunction) => {
                this.databaseService.getAllFromTable(req.params.tableName)
                    .then((result: pg.QueryResult) => {
                        res.json(result.rows);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
            });
        return router;
    }
}
