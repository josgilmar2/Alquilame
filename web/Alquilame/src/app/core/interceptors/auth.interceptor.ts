import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
} from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor() {}

  intercept(req: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    if (req.url != 'http://localhost:8080/auth/login') {

      req = req.clone({
        setHeaders: {
          'Access-Control-Allow-Origin': 'http://localhost:4200',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
          'Access-Control-Allow-Headers': 'X-Requested-With, Content-Type, Authorization'
        }
      });

      let authReq = req;
      const token = localStorage.getItem('token');
      if (token != null) {
        authReq = req.clone({ headers: req.headers.set('Authorization', 'Bearer ' + token) });
      }

      return next.handle(authReq);
    }
    return next.handle(req);
  }
}
