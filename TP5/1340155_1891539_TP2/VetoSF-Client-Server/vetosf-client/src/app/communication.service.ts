import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import * as tb from "../../../common/tables";
// tslint:disable-next-line:ordered-imports
import { of, Observable, concat, Subject } from "rxjs";
import { catchError } from "rxjs/operators";

@Injectable()
export class CommunicationService {

  
    private readonly BASE_URL: string = "http://localhost:3000/database";
    public constructor(private http: HttpClient) { }

    private _listners: any = new Subject<any>();

    public listen(): Observable<any> {
        return this._listners.asObservable();
    }

    public filter(filterBy: string): void {
        this._listners.next(filterBy);
    }


    public getClinics(): Observable<any[]> {

        return this.http.get<tb.Clinic[]>(this.BASE_URL + "/clinic").pipe(
            catchError(this.handleError<tb.Clinic[]>("getClinics")),
        );
    }

    /**
     * getOwnersFromClinicID
     */
    public getOwnerPKFromClinicID(cid: string) {

        return this.http.get<string[]>(this.BASE_URL + "/owners/" + cid).pipe(
            catchError(this.handleError<string[]>("getOwnersPKs")),
        );

    }

    public getPetsPKFromOnCID(ownerid: string, clinicid: string): Observable<string[]> {
        return this.http.get<string[]>(this.BASE_URL + "/pets/" + clinicid + "/" + ownerid).pipe(
            catchError(this.handleError<string[]>("getPetsPKFromOnCID")),
        );
    }

    public getExamPks(ownerid: string, clinicid: string, petid: string): Observable<string[]> {
        return this.http.get<string[]>(this.BASE_URL + "/exams/" + clinicid + "/" + ownerid + "/" + petid).pipe(
            catchError(this.handleError<string[]>("getExamPks")),
        );
    }

    public getTreatPks(examid: string): Observable<string[]> {
        return this.http.get<string[]>(this.BASE_URL + "/treats/" + examid).pipe(
            catchError(this.handleError<string[]>("getTreatPks")),
        );
    }



    public getPet(petKey: any): Observable<string[]> {
        console.log("requesting post pet from the server");
        console.log(petKey);
        return this.http.post<string[]>(this.BASE_URL + "/getpet", petKey).pipe(
            catchError(this.handleError<string[]>("getOwner")),
        );
    }

    public updatePet(petKey: any): Observable<number> {
        console.log("requesting post owner from the server");
        console.log(petKey);
        return this.http.post<number>(this.BASE_URL + "/updatepet", petKey).pipe(
            catchError(this.handleError<number>("updatePet")),
        );
    }

    public newPet(petKey: any): Observable<number> {
        console.log("requesting post owner from the server");
        console.log(petKey);
        return this.http.post<number>(this.BASE_URL + "/newPet", petKey).pipe(
            catchError(this.handleError<number>("updatePet")),
        );
    }

    public deletePet(petKey: any): Observable<number> {
        console.log("requesting post owner from the server");
        console.log(petKey);
        return this.http.post<number>(this.BASE_URL + "/deletepet", petKey).pipe(
            catchError(this.handleError<number>("deletePet")),
        );
    } 

    public fillTreatDetails(treatKey: any): Observable<string[]> {
        console.log("requesting post owner from the server");
        console.log(treatKey);
        return this.http.post<string[]>(this.BASE_URL + "/gettreat", treatKey).pipe(
            catchError(this.handleError<string[]>("fillTreatDetails")),
        );
    }


    public getOwner(ownerKey: any): Observable<string[]> {
        console.log("requesting post owner from the server");
        console.log(ownerKey);
        return this.http.post<string[]>(this.BASE_URL + "/getowner", ownerKey).pipe(
            catchError(this.handleError<string[]>("getOwner")),
        );
    }

    public updateOwner(uownerKey: any): Observable<number> {
        console.log("requesting post update on owner from " + this.BASE_URL + "/ownerupdate");
        return this.http.post<number>(this.BASE_URL + "/updateowner", uownerKey).pipe(
            catchError(this.handleError<number>("updateowner")),
        );
      }

    public getClinicsPK(): Observable<string[]> {
        return this.http.get<string[]>(this.BASE_URL + "/clinics/ids").pipe(
            catchError(this.handleError<string[]>("getClinicsPKs")),
        );
    }

    public insertClinic(clinic: any): Observable<number> {
        return this.http.post<number>(this.BASE_URL + "/Clinic/insert", clinic).pipe(
            catchError(this.handleError<number>("inserClinic")),
        );
    }

    public insertOwner(owner: tb.Owner): Observable<number> {
        return this.http.post<number>(this.BASE_URL + "/owner/insert", owner).pipe(
            catchError(this.handleError<number>("insertOwner")),
        );
    }

    public setUpDatabase(): Observable<any> {
        return concat(this.http.post<any>(this.BASE_URL + "/createSchema", []),
            this.http.post<any>(this.BASE_URL + "/populateDb", []));
    }

    private handleError<T>(request: string, result?: T): (error: Error) => Observable<T> {

        return (error: Error): Observable<T> => {
            return of(result as T);
        };
    }
}
