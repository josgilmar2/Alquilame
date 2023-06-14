import { Component, OnInit } from '@angular/core';
import { DashboardService } from 'src/app/core/services/dashboard.service';
import { ErrorService } from 'src/app/core/services/error.service';
import { DwellingsMostRented } from 'src/app/shared/models/interfaces/dashboard/dwellings_most_rented';
import { UserWithMostRentals } from 'src/app/shared/models/interfaces/dashboard/user_with_most_rentals';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

  isSidenavVisible: boolean = false;
  numberOfUsers: number = 0;
  totalSales: number = 0;
  cargando: boolean = true;
  usersWithMostRentals: UserWithMostRentals[] = [];
  dwellingsMostRented: DwellingsMostRented[] = [];

  constructor(private dashboardService: DashboardService, private errorService: ErrorService) { }

  ngOnInit(): void {
    this.getNumberOfUsers();
    this.getTotalSales();
    this.getUsersWithMostRentals();
    this.getDwellingsMostRented();
  }

  toggleSidenav() {
    this.isSidenavVisible = !this.isSidenavVisible;
  }

  getNumberOfUsers() {
    this.dashboardService.getNumberOfUsers().subscribe(res => {
      this.numberOfUsers = res;
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard');
    });
  }

  getTotalSales() {
    this.dashboardService.getTotalSales().subscribe(res => {
      this.totalSales = res;
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard');
    })
  }

  getUsersWithMostRentals() {
    this.cargando = true;
    this.dashboardService.getUsersWithMostRentals().subscribe(res => {
      this.usersWithMostRentals = res;
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard');
    });
  }

  getDwellingsMostRented() {
    this.cargando = true;
    this.dashboardService.getDwellingsMostRented().subscribe(res => {
      this.dwellingsMostRented = res;
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard');
    });
  }

}
