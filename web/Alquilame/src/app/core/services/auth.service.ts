import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { LoginRequest } from 'src/app/shared/models/dto/auth/login_request.dto';
import { RefreshTokenRequest } from 'src/app/shared/models/dto/auth/refresh_token.dto';
import { LoginResponse } from 'src/app/shared/models/interfaces/auth/login_response.interface';
import { RefreshTokenResponse } from 'src/app/shared/models/interfaces/auth/refresh_token_response.interface';
import { environment } from 'src/environments/environment';

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient, private router: Router) { }

  login(loginRequest: LoginRequest): Observable<LoginResponse> {
    const url = `${environment.API_BASE_URL}/auth/login`;

    return this.http.post<LoginResponse>(url, loginRequest, httpOptions);
  }

  refreshToken(refreshToken: RefreshTokenRequest): Observable<RefreshTokenResponse> {
    const url = `${environment.API_BASE_URL}/auth/refreshtoken`;
    return this.http.post<RefreshTokenResponse>(url, refreshToken, httpOptions);
  }

  logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('refresh_token');
    this.router.navigate(['login']);
  }
}
