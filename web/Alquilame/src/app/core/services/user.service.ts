import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { UserProfile } from 'src/app/shared/models/interfaces/user_profile.interface';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  /*getProfile(): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/user/profile`;

    if(localStorage.getItem('token') || sessionStorage.getItem('token')) {
      return this.http.get<UserProfile>(url);
    }
    throw new Error("El token");
  }*/
}
