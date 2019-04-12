import { Component, OnInit } from "@angular/core";
import { CommunicationService } from "../communication.service";
import { FormGroup, FormControl } from '@angular/forms';
import { Observable } from 'rxjs';
import { startWith, map } from 'rxjs/operators';
import { Owner } from '../../../../common/tables';

@Component({
  selector: "app-registration",
  templateUrl: "./registration.component.html",
  styleUrls: ["./registration.component.css"]
})


export class RegistrationComponent implements OnInit {
  
  public searchOwnerId: FormControl = new FormControl();
  public ClinicPKs: string[] = [];
  public ownerPks: string[] = [];
  public ownerFiltered: Observable<string[]>;
  public duplicateError: boolean = false;
  public invalidClinicPK: boolean = false;
  public selectedClinicID: string;
  public selectedOwnerID: string;
  public currentOwner: Owner;

  public constructor(private communicationService: CommunicationService) { }
  ngOnInit(): void {
    this.communicationService.getClinicsPK().subscribe((clinicsID: string[]) => {
     this.ClinicPKs = clinicsID;
     this.ownerFiltered = this.searchOwnerId.valueChanges
     .pipe(
       startWith(''),
       map(value => this._filter(value))
     );
     
     console.log(this.ClinicPKs);
      console.log(this.duplicateError);
    });
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

  /**
   * onSelectedClinic
clinic: string : void   */
  public onSelectedClinic(clinicid: string): void  {
    this.selectedClinicID = clinicid;
    this.communicationService.getOwnerPKFromClinicID(clinicid).subscribe((ownersID: string[]) => {
      this.ownerPks = ownersID;
      console.log(this.ownerPks);
      this.ownerFiltered = this.searchOwnerId.valueChanges
     .pipe(
       startWith(''),
       map(value => this._filter(value))
     );
    });
  };

  public fillOwnerDetails(ownerid: string) : void {
    if (this.ownerPks.indexOf(ownerid) !== -1) {
      
    }
  };

  private _filter(value: string): string[] {
    const filterValue = value.toLowerCase();

    return this.ownerPks.filter(option => option.toLowerCase().includes(filterValue));
  }
}
