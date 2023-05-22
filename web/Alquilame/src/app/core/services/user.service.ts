import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { CreateUserDto } from 'src/app/shared/models/dto/user/create_user.dto';
import { EditUserDto } from 'src/app/shared/models/dto/user/edit_user.dto';
import { AllUserResponse, User } from 'src/app/shared/models/interfaces/user/all_user_response.interface';
import { UserProfile } from 'src/app/shared/models/interfaces/user/user_profile.interface';
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

  deleteUser(id: string) {
    const url = `${environment.apiBaseUrl}/user/${id}`;
    if(localStorage.getItem('token') != '') {
      return this.http.delete(url);
    }
    throw new Error("El token no existe");
  }

  banUser(id: string): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/user/ban/${id}`;
    if (localStorage.getItem('token') != '') {
      return this.http.put<UserProfile>(url, null);
    }
    throw new Error("El token no existe");
  }

  unbanUser(id: string): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/user/unban/${id}`;
    if (localStorage.getItem('token') != '') {
      return this.http.put<UserProfile>(url, null);
    }
    throw new Error("El token no existe");
  }

  searchUser(termino: string): Observable<AllUserResponse> {
    const url = `${environment.apiBaseUrl}/user/?search=username:${termino}`;
    if (localStorage.getItem('token') != '') {
      return this.http.get<AllUserResponse>(url);
    }
    throw new Error("El token no existe");
  }

  getOneUser(id: string): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/user/${id}`;
    if (localStorage.getItem('token') != '') {
      return this.http.get<UserProfile>(url);
    }
    throw new Error("El token no existe");
  }

  createInquilino(user: CreateUserDto): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/auth/register/inquilino`;
    if(localStorage.getItem('token') != '') {
      return this.http.post<UserProfile>(url , user);
    }
    throw new Error("El token no existe");
  }


  createPropietario(user: CreateUserDto): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/auth/register/propietario`;
    if (localStorage.getItem('token') != '') {
      return this.http.post<UserProfile>(url, user);
    }
    throw new Error("El token no existe");
  }

  createAdmin(user: CreateUserDto): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/auth/register/admin`;
    if (localStorage.getItem('token') != '') {
      return this.http.post<UserProfile>(url, user);
    }
    throw new Error("El token no existe");
  }

  editUser(user: EditUserDto, id: string): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/user/${id}`;
    if (localStorage.getItem('token') != '') {
      return this.http.put<UserProfile>(url, user);
    }
    throw new Error("El token no existe");
  }

  editAvatar(file: File, id: string): Observable<UserProfile> {
    const url = `${environment.apiBaseUrl}/user/${id}/changeAvatar`;
    const formData = new FormData();
    formData.append('file', file);
    if (localStorage.getItem('token') != '') {
      return this.http.put<UserProfile>(url, formData);
    }
    throw new Error("El token no existe");
  }

  getAdmins(): Observable<UserProfile[]> {
    const url = `${environment.apiBaseUrl}/user/admins`;
    if (localStorage.getItem('token') != '') {
      return this.http.get<UserProfile[]>(url);
    }
    throw new Error("El token no existe");
  }
 }
