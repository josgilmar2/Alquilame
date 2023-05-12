import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DashboardComponent } from './dashboard/dashboard.component';
import { SharedModule } from '../shared/shared.module';
import { RouterModule } from '@angular/router';
import { UsersComponent } from './users/users.component';
import { DwellingsComponent } from './dwellings/dwellings.component';
import { ImagenPipe } from '../core/pipes/imagen.pipe';



@NgModule({
  declarations: [
    DashboardComponent,
    UsersComponent,
    DwellingsComponent,
    ImagenPipe
  ],
  imports: [
    CommonModule,
    RouterModule,
    SharedModule
  ]
})
export class PagesModule { }
