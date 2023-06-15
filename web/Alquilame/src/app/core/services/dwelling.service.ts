import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { CreateDwellingDto } from 'src/app/shared/models/dto/dwelling/create_dwelling.dto';
import { AllDwellingResponse } from 'src/app/shared/models/interfaces/dwelling/all_dwellings_response.interface';
import { OneDwellingResponse } from 'src/app/shared/models/interfaces/dwelling/one_dwelling_response.interface';
import { environment } from 'src/environments/environment';

const httpAuthOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': 'Bearer' + localStorage.getItem('token'),
  })
};

@Injectable({
  providedIn: 'root'
})
export class DwellingService {

  constructor(private http: HttpClient) { }

  getAllDwellings(page: number): Observable<AllDwellingResponse> {
    const url = `${environment.API_BASE_URL}/dwelling/?page=${page}`;
    if (localStorage.getItem('token') != '') {
      return this.http.get<AllDwellingResponse>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  searchDwelling(termino: string): Observable<AllDwellingResponse> {
    const url = `${environment.API_BASE_URL}/dwelling/?search=name:${termino}`;
    if (localStorage.getItem('token') != '') {
      return this.http.get<AllDwellingResponse>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  deleteDwelling(id: number) {
    const url = `${environment.API_BASE_URL}/dwelling/${id}`;
    if(localStorage.getItem('token') != '') {
      return this.http.delete(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  getOneDwelling(id: number): Observable<OneDwellingResponse> {
    const url = `${environment.API_BASE_URL}/dwelling/${id}`;
    if(localStorage.getItem('token') != '') {
      return this.http.get<OneDwellingResponse>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");
  }

  createDwelling(dto: CreateDwellingDto, file: File): Observable<OneDwellingResponse> {
    const formData: FormData = new FormData();
    const body = new Blob([JSON.stringify(dto)], {
      type: 'application/vnd.api+json'
    });
    const url = `${environment.API_BASE_URL}/dwelling/`;

    formData.append('file', file);
    formData.append('body', body);

    if(localStorage.getItem('token') != '') {
      return this.http.post<OneDwellingResponse>(url, formData);
    }
    throw new Error("El token no existe");
  }

  editDwelling(dto: CreateDwellingDto, file: File, id: number): Observable<OneDwellingResponse> {
    const formData: FormData = new FormData();
    const body = new Blob([JSON.stringify(dto)], {
      type: 'application/vnd.api+json'
    });
    const url = `${environment.API_BASE_URL}/dwelling/${id}`;

    formData.append('file', file);
    formData.append('body', body);

    if(localStorage.getItem('token') != '') {
      return this.http.put<OneDwellingResponse>(url, formData);
    }
    throw new Error("El token no existe");
  }
}
