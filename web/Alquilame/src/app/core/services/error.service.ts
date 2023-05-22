import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { RefreshTokenRequest } from 'src/app/shared/models/dto/auth/refresh_token.dto';
import Swal from 'sweetalert2';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ErrorService {

  refreshToken: string = '';

  constructor(private router: Router, private authService: AuthService) { }

  errorsManage(err: any, route: string, subErrors?: boolean) {
    if (err.error.statusCode === 400) {
      if (!subErrors) {
        Swal.fire('Error', err.error.message, 'error');
        this.router.navigate([route]);
      } else {
        if (!err.error.subErrors) {
          Swal.fire('¡Error!', 'La imagen debe de ser válida', 'error');
        } else {
          Swal.fire('Error', err.error.subErrors[0].message, 'error');
        }
      }
    } else if (err.error.statusCode === 401) {
      Swal.fire('Error', err.error.message, 'error');
      localStorage.clear();
      this.router.navigate(['login']);
    } else if (err.error.statusCode === 403) {
      this.refreshToken = localStorage.getItem('refresh_token') || '';
      if(this.refreshToken != '') {
        this.authService.refreshToken(new RefreshTokenRequest(this.refreshToken)).subscribe(res => {
          localStorage.setItem('token', res.token);
          localStorage.setItem('refresh_token', res.refreshToken);
          location.reload();
        }, (err) => {
          Swal.fire("Error", "Se ha caducado la sesión", 'info');
          localStorage.clear();
          this.router.navigate(['login']);
        });
      } else {
        localStorage.clear();
        this.router.navigate(['login']);
      }
    } else if (err.error.statusCode === 404) {
      Swal.fire('Error', err.error.message, 'error');
      this.router.navigate([route]);
    } else {
      Swal.fire('Error', 'Hubo un error inesperado', 'error');
      localStorage.clear();
      this.router.navigate(['login']);
    }
  }
}
