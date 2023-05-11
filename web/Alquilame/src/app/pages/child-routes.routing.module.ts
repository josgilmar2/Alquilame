import { Routes, RouterModule } from "@angular/router";
import { NgModule } from "@angular/core";
import { DashboardComponent } from "./dashboard/dashboard.component";
import { UsersComponent } from "./users/users.component";
import { DwellingsComponent } from "./dwellings/dwellings.component";


const childRoutes: Routes = [
  { path: '', component: DashboardComponent, data: { titulo: 'Dashboard' } },
  { path: 'users', component: UsersComponent, data: { titulo: 'Usuarios' } },
  { path: 'dwellings', component: DwellingsComponent, data: { titulo: 'Viviendas' } }
];

@NgModule({
  imports: [RouterModule.forChild(childRoutes)],
  exports: [RouterModule]
})
export class ChildRoutesRoutingModule {}
