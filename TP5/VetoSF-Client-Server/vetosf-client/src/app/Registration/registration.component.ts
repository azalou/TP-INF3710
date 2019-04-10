import { Component, OnInit } from "@angular/core";
import { CommunicationService } from "../communication.service";
import { Clinic } from '../../../../common/tables';

@Component({
  selector: "app-registration",
  templateUrl: "./registration.component.html",
  styleUrls: ["./registration.component.css"]
})

export class RegistrationComponent implements OnInit {
  public constructor(private communicationService: CommunicationService) { }

  public ClinicPKs: string[] = [];
  public duplicateError: boolean = false;
  public invalidClinicPK: boolean = false;
  ngOnInit(): void {
    this.communicationService.getClinicsPK().subscribe((clinicsID: string[]) => {
      this.ClinicPKs = clinicsID;
      console.log(this.duplicateError);
      console.log(this.ClinicPKs);
      
    } );
  }



  public insertOwner(ownerID: string, cID: string, name: string, phone: string, address: string): void {
    const owner: any = {
        "ownerID"   : ownerID,
        "cID"       : cID,
        "name"      : name,
        "phone"     : phone,
        "address"   : address
    };


    this.communicationService.insertOwner(owner).subscribe((res: number) => {
        if (res > 0) {
            this.communicationService.filter("update");
        }
        this.duplicateError = (res === -1);
    });
  }
}
