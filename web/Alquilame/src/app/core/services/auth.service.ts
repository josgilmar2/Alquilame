import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { LoginRequest } from 'src/app/shared/models/dto/login_request.dto';
import { LoginResponse } from 'src/app/shared/models/interfaces/login_response.interface';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient, private router: Router) { }

  login(loginRequest: LoginRequest): Observable<LoginResponse> {
    const url = `${environment.apiBaseUrl}/auth/login`;

    return this.http.post<LoginResponse>(url, loginRequest);
  }

  logout() {
    localStorage.removeItem('token');
    this.router.navigate(['login']);
  }
}
