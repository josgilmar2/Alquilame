import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DashboardComponent } from './dashboard/dashboard.component';
import { SharedModule } from '../shared/shared.module';
import { PagesComponent } from './pages.component';
import { RouterModule } from '@angular/router';
import { UsersComponent } from './users/users.component';
import { DwellingsComponent } from './dwellings/dwellings.component';



@NgModule({
  declarations: [
    DashboardComponent,
    PagesComponent,
    UsersComponent,
    DwellingsComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    SharedModule
  ]
})
export class PagesModule { }
