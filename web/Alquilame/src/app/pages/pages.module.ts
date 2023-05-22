import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DashboardComponent } from './dashboard/dashboard.component';
import { SharedModule } from '../shared/shared.module';
import { RouterModule } from '@angular/router';
import { UsersListComponent } from './user/users-list/users-list.component';
import { DwellingsListComponent } from './dwelling/dwellings-list/dwellings-list.component';
import { AvatarPipe } from '../core/pipes/avatar.pipe';
import { PagesComponent } from './pages.component';
import { UserFormComponent } from './user/user-form/user-form.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DwellingFormComponent } from './dwelling/dwelling-form/dwelling-form.component';
import { ImagenPipe } from '../core/pipes/imagen.pipe';
import { DwellingDetailsComponent } from './dwelling/dwelling-details/dwelling-details.component';
import { ProfileComponent } from './user/profile/profile.component';


@NgModule({
  declarations: [
    DashboardComponent,
    UsersListComponent,
    DwellingsListComponent,
    AvatarPipe,
    ImagenPipe,
    PagesComponent,
    UserFormComponent,
    DwellingFormComponent,
    DwellingDetailsComponent,
    ProfileComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    SharedModule,
    ReactiveFormsModule,
    FormsModule
  ]
})
export class PagesModule { }
