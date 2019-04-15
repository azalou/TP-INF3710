import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import * as pg from "pg";

import { DatabaseService } from "../services/database.service";
import Types from "../types";
import { Clinic, Owner, Pet, Treatment } from "../../../common/tables";

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

        router.get("/clinics/ids",
            (req: Request, res: Response, next: NextFunction) => {
                this.databaseService.getClinicId().then((result: pg.QueryResult) => {
                    const clinicPKs: string[] = result.rows.map((row: any) => row.cid);
                    res.json(clinicPKs);
                }).catch((e: Error) => {
                    console.error(e.stack);
                });
            });

         router.post("/updateowner",
            (req: Request, res: Response, next: NextFunction) => {
                console.log("updating the owner");
                console.log(req.body);
                this.databaseService.updateOwner(req.body).then((result: pg.QueryResult) => {
                    const owner: Owner[] = result.rows.map((owner: Owner) => (
                        {
                            ownerid: owner.ownerid,
                            cid: owner.cid,
                            name: owner.name,
                            phone: owner.phone,
                            address: owner.address
                        }));
                    console.log("we are sending this");
                    console.log(owner);
                    console.log("===========================");
                    res.json(owner);
                }).catch((e: Error) => {
                    console.error(e.stack);
                });
            });

        router.post("/getowner",
            (req: Request, res: Response, next: NextFunction) => {
                console.log("getting the right owner");
                console.log(req.body);
                this.databaseService.getOwnerFromParams(req.body)
                    .then((result: pg.QueryResult) => {
                        const owner: Owner[] = result.rows.map((owner: Owner) => (
                            {
                                ownerid: owner.ownerid,
                                cid: owner.cid,
                                name: owner.name,
                                phone: owner.phone,
                                address: owner.address
                            }));
                        console.log("we are sending this");
                        console.log(owner);
                        console.log("===========================");
                        res.json(owner);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
            });

            router.post("/gettreat",
            (req: Request, res: Response, next: NextFunction) => {
                console.log("getting the right treatment");
                console.log(req.body);
                this.databaseService.getTreatmentFromParams(req.body)
                    .then((result: pg.QueryResult) => {
                        const treatment: Treatment[] = result.rows.map((treat: Treatment) => (
                            {
                                treatid: treat.treatid,
                                description: treat.description,
                                tcost: treat.tcost,
                                examid: treat.examid,
                                quantity: treat.quantity,
                                sdate: treat.sdate,
                                edate: treat.edate
                            }));
                        console.log("we are sending this");
                        console.log(treatment);
                        console.log("===========================");
                        res.json(treatment);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
            });


            router.post("/deletePet",
            (req: Request, res: Response, next: NextFunction) => {
                console.log("updating the pet");
                console.log(req.body);
                this.databaseService.deletePet(req.body)
                    .then((result: pg.QueryResult) => {
                        
                        console.log("we are deleting this");
                        console.log(req.body);
                        console.log("===========================");
                        res.json(result);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
            });

            router.post("/updatepet",
            (req: Request, res: Response, next: NextFunction) => {
                console.log("updating the pet");
                console.log(req.body);
                this.databaseService.updatePet(req.body)
                    .then((result: pg.QueryResult) => {
                        console.log("we are updating this");
                        console.log("===========================");
                        res.json(result);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
            });

            router.post("/newPet",
            (req: Request, res: Response, next: NextFunction) => {
                console.log("updating the pet");
                console.log(req.body);
                this.databaseService.newPet(req.body)
                    .then((result: pg.QueryResult) => {
                        console.log("we are updating this");
                        console.log("===========================");
                        res.json(result);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
            });

        router.post("/getpet",
            (req: Request, res: Response, next: NextFunction) => {
                console.log("getting the right pet")
                console.log(req.body);
                this.databaseService.getPetFromParams(req.body)
                    .then((result: pg.QueryResult) => {
                        const pet: Pet[] = result.rows.map((pet: Pet) => (
                            {
                                ownerid: pet.ownerid,
                                cid: pet.cid,
                                petid: pet.petid,
                                name: pet.name,
                                specie: pet.specie,
                                description: pet.description,
                                dob: pet.dob,
                                status: pet.status
                            }));
                        console.log("we are sending this");
                        console.log(pet);
                        console.log("===========================");
                        res.json(pet);
                    }).catch((e: Error) => {
                        console.error(e.stack);
                    });
            });

        router.get("/owners/:cid",
            (req: Request, res: Response, next: NextFunction) => {
                this.databaseService.getOwnerIdsFromClinic(req.params.cid).then((result: pg.QueryResult) => {
                    const ownersPK: string[] = result.rows.map((row: any) => row.ownerid);
                    console.log("we are sending this");
                    console.log(ownersPK);
                    res.json(ownersPK);
                }).catch((e: Error) => {
                    console.error(e.stack);
                });
            });

        router.get("/pets/:cid/:ownerid",
            (req: Request, res: Response, next: NextFunction) => {
                this.databaseService.getPetsIdsFromOwnerClinic(req.params.cid, req.params.ownerid).then((result: pg.QueryResult) => {
                    const petsPK: string[] = result.rows.map((row: any) => row.petid);
                    console.log("we are sending this");
                    console.log(petsPK);
                    res.json(petsPK);
                }).catch((e: Error) => {
                    console.error(e.stack);
                });
            });

            router.get("/exams/:cid/:ownerid/:petid",
            (req: Request, res: Response, next: NextFunction) => {
                this.databaseService.getExamsIdsFromOwnerClinicPet(req.params.cid, req.params.ownerid, req.params.petid).then((result: pg.QueryResult) => {
                    const examPks: string[] = result.rows.map((row: any) => row.examid);
                    console.log("we are sending this");
                    console.log(examPks);
                    res.json(examPks);
                }).catch((e: Error) => {
                    console.error(e.stack);
                });
            });

            router.get("/treats/:examid",
            (req: Request, res: Response, next: NextFunction) => {
                this.databaseService.getTreatsIdsFromOwnerClinicPetExam(req.params.examid).then((result: pg.QueryResult) => {
                    const treatPks: string[] = result.rows.map((row: any) => row.treatid);
                    console.log("we are sending this");
                    console.log(treatPks);
                    res.json(treatPks);
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
                    address: req.body.address
                };
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
