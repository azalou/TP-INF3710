import { Location } from "@angular/common";
import { Component, OnInit } from '@angular/core';
import { Router } from "@angular/router";
import * as tb  from "../common/tables";
import { CommunicationService } from "./communication.service";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {

  public route: string;

  public constructor(private communicationService: CommunicationService, location: Location, router: Router) {
    router.events.subscribe((val) => {
        if (location.path() !== "") {
          this.route = location.path();
        } else {
          this.route = "";
        }
      });
  }
  public readonly title = 'vetosf-client';
  public clinics: tb.Clinic[] = [];
  public ngOnInit(): void {
    this.communicationService.listen().subscribe((m:any) => {
        console.log(m);
        this.getClinics();
    });
  }

  public getClinics(): void {
    this.communicationService.getClinics().subscribe((clinic: tb.Clinic[]) => {
        this.clinics = clinic;
    });
  }

  public createDB(): void {
    this.communicationService.setUpDatabase().subscribe((res: any) => {
        console.log(res);
    });
}



}