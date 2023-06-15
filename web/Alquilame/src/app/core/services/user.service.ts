import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { CreateUserDto } from 'src/app/shared/models/dto/user/create_user.dto';
import { EditUserDto } from 'src/app/shared/models/dto/user/edit_user.dto';
import { AllUserResponse, User } from 'src/app/shared/models/interfaces/user/all_user_response.interface';
import { UserProfile } from 'src/app/shared/models/interfaces/user/user_profile.interface';
import { environment } from 'src/environments/environment';

const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
};

const httpAuthOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': 'Bearer' + localStorage.getItem('token'),
  })
};

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  getProfile(): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/user/profile`;
    if(localStorage.getItem('token') != '') {
      return this.http.get<UserProfile>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  getAllUsers(page: number): Observable<AllUserResponse> {
    const url = `${environment.API_BASE_URL}/user/?page=${page}`;
    if(localStorage.getItem('token') != '') {
      return this.http.get<AllUserResponse>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  deleteUser(id: string) {
    const url = `${environment.API_BASE_URL}/user/${id}`;
    if(localStorage.getItem('token') != '') {
      return this.http.delete(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  banUser(id: string): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/user/ban/${id}`;
    if (localStorage.getItem('token') != '') {
      return this.http.put<UserProfile>(url, null, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  unbanUser(id: string): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/user/unban/${id}`;
    if (localStorage.getItem('token') != '') {
      return this.http.put<UserProfile>(url, null, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  searchUser(termino: string): Observable<AllUserResponse> {
    const url = `${environment.API_BASE_URL}/user/?search=username:${termino}`;
    if (localStorage.getItem('token') != '') {
      return this.http.get<AllUserResponse>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  getOneUser(id: string): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/user/${id}`;
    if (localStorage.getItem('token') != '') {
      return this.http.get<UserProfile>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  createInquilino(user: CreateUserDto): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/auth/register/inquilino`;
    if(localStorage.getItem('token') != '') {
      return this.http.post<UserProfile>(url , user, httpOptions);
    }
    throw new Error("El token no existe");
  }


  createPropietario(user: CreateUserDto): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/auth/register/propietario`;
    if (localStorage.getItem('token') != '') {
      return this.http.post<UserProfile>(url, user, httpOptions);
    }
    throw new Error("El token no existe");
  }

  createAdmin(user: CreateUserDto): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/auth/register/admin`;
    if (localStorage.getItem('token') != '') {
      return this.http.post<UserProfile>(url, user, httpOptions);
    }
    throw new Error("El token no existe");
  }

  editUser(user: EditUserDto, id: string): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/user/${id}`;
    if (localStorage.getItem('token') != '') {
      return this.http.put<UserProfile>(url, user, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  editAvatar(file: File, id: string): Observable<UserProfile> {
    const url = `${environment.API_BASE_URL}/user/${id}/changeAvatar`;
    const formData = new FormData();
    formData.append('file', file);
    if (localStorage.getItem('token') != '') {
      return this.http.put<UserProfile>(url, formData);
    }
    throw new Error("El token no existe");
  }

 }
