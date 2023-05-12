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
      url: '/users'
    },
    {
      titulo: 'Viviendas',
      icono: 'apartment',
      url: '/dwellings'
    }
  ];

  constructor() { }


}
