import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { DwellingsMostRented } from 'src/app/shared/models/interfaces/dashboard/dwellings_most_rented';
import { UserWithMostRentals } from 'src/app/shared/models/interfaces/dashboard/user_with_most_rentals';
import { environment } from 'src/environments/environment';

const httpAuthOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': 'Bearer' + localStorage.getItem('token'),
  })
};

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private http: HttpClient) { }

  getNumberOfUsers(): Observable<number> {
    const url = `${environment.API_BASE_URL}/user/number`;
    if(localStorage.getItem('token')) {
      return this.http.get<number>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  getTotalSales(): Observable<number> {
    const url = `${environment.API_BASE_URL}/rental/totalSales`;
    if(localStorage.getItem('token')) {
      return this.http.get<number>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  getUsersWithMostRentals(): Observable<UserWithMostRentals[]> {
    const url = `${environment.API_BASE_URL}/ranking/user/more/rental`;
    if(localStorage.getItem('token')) {
      return this.http.get<UserWithMostRentals[]>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  getDwellingsMostRented(): Observable<DwellingsMostRented[]> {
    const url = `${environment.API_BASE_URL}/ranking/dwelling/more/rental`;
    if(localStorage.getItem('token')) {
      return this.http.get<DwellingsMostRented[]>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

}
