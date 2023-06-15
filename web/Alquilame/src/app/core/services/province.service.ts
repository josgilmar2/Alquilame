import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AllProvinceResponse } from 'src/app/shared/models/interfaces/province/all_provinces_response.interface';
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
export class ProvinceService {

  constructor(private http: HttpClient) { }

  /*getAllProvinces(): Observable<AllDwellingResponse> {
    return this.http.get(`${environment.apiBaseUrl}/province/`).pipe(
      mergeMap((response: any) => {
        const totalPages = response.totalPages;
        const nextPageRequests = [of(response)];

        for (let page = 1; page < totalPages; page++) {
          nextPageRequests.push(this.http.get(`${environment.apiBaseUrl}/province/?page=${page}`));
        }

        return concat(...nextPageRequests).pipe(
          map((responses: any[]) => {
            const content = responses.reduce((acc, curr) => acc.concat(curr.data), []);
            const totalElements = response.total_elements;
            const totalPages = response.total_pages;
            const number = response.number;
            const size = response.size;

            return { content, totalElements, totalPages, number, size };
          })
        );
      })
    );
  }*/

  getAllProvinces(): Observable<AllProvinceResponse[]> {
    const url = `${environment.API_BASE_URL}/province/`;
    if (localStorage.getItem('token') != '') {
      return this.http.get<AllProvinceResponse[]>(url, httpAuthOptions);
    }
    throw new Error("El token no existe");

  }
}
