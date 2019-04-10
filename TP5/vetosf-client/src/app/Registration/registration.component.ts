import { Component } from "@angular/core";
import { CommunicationService } from "./../communication.service";

@Component({
  selector: "app-registration",
  templateUrl: "./registration.component.html",
  styleUrls: ["./registration.component.css"]
})

export class RegistrationComponent {

  public constructor(private communicationService: CommunicationService) { }


  public duplicateError: boolean = false;

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
