"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const inversify_1 = require("inversify");
const database_service_1 = require("../services/database.service");
const types_1 = require("../types");
let DatabaseController = class DatabaseController {
    constructor(databaseService) {
        this.databaseService = databaseService;
    }
    get router() {
        const router = express_1.Router();
        router.post("/createSchema", (req, res, next) => {
            this.databaseService.createSchema().then((result) => {
                console.log("CECI EST UNE FONCTION DE TEST SEULEMENT");
                res.json(result);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        router.post("/populateDb", (req, res, next) => {
            this.databaseService.populateDb().then((result) => {
                console.log("CECI EST UNE FONCTION DE TEST SEULEMENT");
                res.json(result);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        router.get("/clinics", (req, res, next) => {
            // Send the request to the service and send the response
            this.databaseService.getClinics().then((result) => {
                const clinics = result.rows.map((cli) => ({
                    cid: cli.cid,
                    phone: cli.phone,
                    fax: cli.fax,
                    road: cli.road,
                    city: cli.city,
                    province: cli.province,
                    pcode: cli.pcode
                }));
                res.json(clinics);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        router.get("/clinics/ids", (req, res, next) => {
            this.databaseService.getClinicId().then((result) => {
                const clinicPKs = result.rows.map((row) => row.cid);
                res.json(clinicPKs);
            }).catch((e) => {
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
        router.get("/owner", (req, res, next) => {
            // this.databaseService.getRoomFromClinic(req.query.clinicid, req.query.ownerType, req.query.price)
            console.log("getting Owners");
            this.databaseService.getOwnerFromClinicParams(req.query)
                .then((result) => {
                const owner = result.rows.map((owner) => ({
                    ownerid: owner.ownerid,
                    cid: owner.cid,
                    name: owner.name,
                    phone: owner.phone,
                    address: owner.address
                }));
                res.json(owner);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        router.get("/owners/:cid", (req, res, next) => {
            this.databaseService.getOwnerIdsFromClinic(req.params.cid).then((result) => {
                const ownersPK = result.rows.map((row) => row.ownerid);
                res.json(ownersPK);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        router.post("/owner/insert", (req, res, next) => {
            const owner = {
                ownerid: req.body.ownerid,
                cid: req.body.cid,
                name: req.body.name,
                phone: req.body.phone,
                address: req.body.address
            };
            console.log(owner);
            this.databaseService.createOwner(owner)
                .then((result) => {
                res.json(result.rowCount);
            })
                .catch((e) => {
                console.error(e.stack);
                res.json(-1);
            });
        });
        router.get("/tables/:tableName", (req, res, next) => {
            this.databaseService.getAllFromTable(req.params.tableName)
                .then((result) => {
                res.json(result.rows);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        return router;
    }
};
DatabaseController = __decorate([
    inversify_1.injectable(),
    __param(0, inversify_1.inject(types_1.default.DatabaseService)),
    __metadata("design:paramtypes", [database_service_1.DatabaseService])
], DatabaseController);
exports.DatabaseController = DatabaseController;
//# sourceMappingURL=database.controller.js.map