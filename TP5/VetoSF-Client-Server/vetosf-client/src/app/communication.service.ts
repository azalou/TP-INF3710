import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import * as tb  from "../../../common/tables";
// tslint:disable-next-line:ordered-imports
import { of, Observable,concat, Subject } from "rxjs";
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
