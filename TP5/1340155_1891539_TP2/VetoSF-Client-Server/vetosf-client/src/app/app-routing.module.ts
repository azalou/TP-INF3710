import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AppComponent } from "./app.component";
import { RegistrationComponent } from './Registration/registration.component';
import { HomeComponent } from './home/home.component';
import { MedicalFilesComponent } from './medical-files/medical-files.component';
import { EmployeesComponent } from "./employees/employees.component";
import { AppointmentsComponent } from './appointments/appointments.component';

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: "registration", component: RegistrationComponent},
  { path: "home", component: HomeComponent},
  { path: "medical-files", component: MedicalFilesComponent},
  { path: "employees", component: EmployeesComponent},
  { path: "appointments", component: AppointmentsComponent },
  { path: "", redirectTo: "/home", pathMatch: "full"}
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
