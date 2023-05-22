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
    const token: string = localStorage.getItem('token') || '';
    let request = req;

    if (token != '' && req.url != 'http://localhost:8080/auth/refreshtoken') {
      request = req.clone({
        headers: req.headers.set('Authorization', 'Bearer ' + token)
      });
    }

    return next.handle(request);
  }
}
