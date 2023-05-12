import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AllUserResponse } from 'src/app/shared/models/interfaces/all_user_response.interface';
import { UserProfile } from 'src/app/shared/models/interfaces/user_profile.interface';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  getProfile(): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/user/profile`;
    if(localStorage.getItem('token') != '') {
      return this.http.get<UserProfile>(url);
    }
    throw new Error("El token no existe");
  }

  getAllUsers(page: number): Observable<AllUserResponse> {
    const url = `${environment.apiBaseUrl}/user/?page=${page}`;
    if(localStorage.getItem('token') != '') {
      return this.http.get<AllUserResponse>(url);
    }
    throw new Error("El token no existe");
  }
}
