import { Component, OnInit } from '@angular/core';
import { DwellingService } from 'src/app/core/services/dwelling.service';
import { ErrorService } from 'src/app/core/services/error.service';
import { Dwelling } from 'src/app/shared/models/interfaces/dwelling/all_dwellings_response.interface';

@Component({
  selector: 'app-dwellings',
  templateUrl: './dwellings-list.component.html',
  styleUrls: ['./dwellings-list.component.css']
})
export class DwellingsListComponent implements OnInit {

  cargando: boolean = true;
  page: number = 0;
  dwellings: Dwelling[] = [];
  totalPages: number = 0;
  pagesNumber: number[] = [];
  termino: string = '';
  viviendaDelete: Dwelling = {} as Dwelling;

  constructor(private dwellingService: DwellingService, private errorService: ErrorService) { }

  ngOnInit(): void {
    this.getAllDwellings();
  }

  getAllDwellings() {
    this.cargando = true;
    this.dwellingService.getAllDwellings(this.page).subscribe(res => {
      this.cargando = false;
      this.dwellings = res.content;
      this.totalPages = res.totalPages;
      this.pagesNumber = Array.from({ length: this.totalPages }, (_, index) => index + 1);
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard/dwellings');
    });
  }

  pageBefore() {
    if (this.page > 0) {
      this.page = this.page - 1;
      this.getAllDwellings();
    }
  }

  pageNext() {
    if (this.page < this.totalPages) {
      this.page = this.page + 1;
      this.getAllDwellings();
    }
  }

  pageSelected(pageNumber: number) {
    this.page = pageNumber;
    this.getAllDwellings();
  }

  buscarVivienda(termino: string) {
    if (termino.trim().length === 0) {
      return this.getAllDwellings();
    }
    return this.dwellingService.searchDwelling(termino).subscribe(res => {
      this.dwellings = res.content;
    });
  }

  viviendaAEliminar(dwelling: Dwelling) {
    this.viviendaDelete = dwelling;
  }

  borrarVivienda() {
    this.dwellingService.deleteDwelling(this.viviendaDelete.id).subscribe(res => {
      location.reload();
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard/dwellings');
    });
  }

}
