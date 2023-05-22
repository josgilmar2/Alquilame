import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SidenavService {

  menu: any = [
    {
      titulo: 'Dashboard',
      icono: 'dashboard',
      url: '/dashboard'
    },
    {
      titulo: 'Usuarios',
      icono: 'manage_accounts',
      url: '/dashboard/users'
    },
    {
      titulo: 'Añadir Usuario',
      icono: 'person_add',
      url: '/dashboard/add-user'
    },
    {
      titulo: 'Viviendas',
      icono: 'apartment',
      url: '/dashboard/dwellings'
    },
    {
      titulo: 'Añadir Vivienda',
      icono: 'add_home',
      url: '/dashboard/add-dwelling'
    },
    {
      titulo: 'Perfil',
      icono: 'person',
      url: '/dashboard/profile'
    },
    {
      titulo: 'Logout',
      icono: 'logout',
      url:'/login'
    }
  ];

  constructor() { }


}
