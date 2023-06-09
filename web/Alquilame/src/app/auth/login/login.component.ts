import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/core/services/auth.service';
import { ErrorService } from 'src/app/core/services/error.service';
import { LoginRequest } from 'src/app/shared/models/dto/auth/login_request.dto';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  myForm: FormGroup = this.fb.group({
    username: ['', Validators.required],
    password: ['', Validators.required],
    remember: [false]
  })

  constructor(private fb: FormBuilder, private authService: AuthService, private router: Router, private errorService: ErrorService) { }

  ngOnInit(): void {
  }

  login() {
    const loginRequest: LoginRequest = {
      username: this.myForm.get('username')?.value,
      password: this.myForm.get('password')?.value
    }

    this.authService.login(loginRequest).subscribe(resp => {
      if (resp.role === 'ADMIN') {
        localStorage.setItem('token', resp.token);
        localStorage.setItem('refresh_token', resp.refreshToken);
        this.router.navigate(['dashboard']);
      } else {
        Swal.fire('Error', 'No tienes permisos para entrar como administrador', 'error');
      }
    }, (err) => {
      this.errorService.errorsManage(err, '/login');
    });
  }

}
