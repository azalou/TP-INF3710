import { CommonModule } from "@angular/common";
import { HttpClientModule } from "@angular/common/http";
import { NgModule } from "@angular/core";
import { ReactiveFormsModule, FormsModule} from "@angular/forms";
import { BrowserModule } from "@angular/platform-browser";
import { AppRoutingModule } from "./app-routing.module";
import { AppComponent } from "./app.component";
import { CommunicationService } from "./communication.service";
import { RegistrationComponent } from './Registration/registration.component';
import { HomeComponent } from './home/home.component';
import { MatFormFieldModule, MatInputModule, MatAutocompleteModule } from "@angular/material"
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { MedicalFilesComponent } from './medical-files/medical-files.component';
import { AppointmentsComponent } from './appointments/appointments.component';
import { EmployeesComponent } from './employees/employees.component';


@NgModule({
  declarations: [
    AppComponent,
    RegistrationComponent,
    HomeComponent,
    MedicalFilesComponent,
    AppointmentsComponent,
    EmployeesComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    AppRoutingModule,
    MatFormFieldModule,
    MatInputModule,
    MatAutocompleteModule,
    BrowserAnimationsModule
  ],
  providers: [CommunicationService],
  bootstrap: [AppComponent]
})
export class AppModule { }
