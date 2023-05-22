import { Routes, RouterModule } from "@angular/router";
import { NgModule } from "@angular/core";
import { DashboardComponent } from "./dashboard/dashboard.component";
import { UsersListComponent } from "./user/users-list/users-list.component";
import { DwellingsListComponent } from "./dwelling/dwellings-list/dwellings-list.component";
import { UserFormComponent } from "./user/user-form/user-form.component";
import { DwellingFormComponent } from "./dwelling/dwelling-form/dwelling-form.component";
import { DwellingDetailsComponent } from "./dwelling/dwelling-details/dwelling-details.component";
import { ProfileComponent } from "./user/profile/profile.component";


const childRoutes: Routes = [
  { path: '', component: DashboardComponent, data: { titulo: 'Dashboard' } },
  { path: 'users', component: UsersListComponent, data: { titulo: 'Usuarios' } },
  { path: 'dwellings', component: DwellingsListComponent, data: { titulo: 'Viviendas' } },
  { path: 'add-user', component: UserFormComponent, data: { titulo: 'Añadir Usuario' } },
  { path: 'edit-user/:id', component: UserFormComponent, data: { titulo: 'Editar Usuario' } },
  { path: 'dwellings/:id', component: DwellingDetailsComponent, data: { titulo: 'Detalles Vivienda' } },
  { path: 'add-dwelling', component: DwellingFormComponent, data: { titulo: 'Añadir Vivienda' } },
  { path: 'edit-dwelling/:id', component: DwellingFormComponent, data: { titulo: 'Editar Vivienda' } },
  { path: 'profile', component: ProfileComponent, data: { titulo: 'Perfil' } }
];

@NgModule({
  imports: [RouterModule.forChild(childRoutes)],
  exports: [RouterModule]
})
export class ChildRoutesRoutingModule {}
