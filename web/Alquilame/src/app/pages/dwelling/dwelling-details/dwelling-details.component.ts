import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { DwellingService } from 'src/app/core/services/dwelling.service';
import { OneDwellingResponse } from 'src/app/shared/models/interfaces/dwelling/one_dwelling_response.interface';

@Component({
  selector: 'app-dwelling-details',
  templateUrl: './dwelling-details.component.html',
  styleUrls: ['./dwelling-details.component.css']
})
export class DwellingDetailsComponent implements OnInit {

  dwellingId: number = 0;
  dwelling: OneDwellingResponse = {} as OneDwellingResponse;

  constructor(
    private route: ActivatedRoute,
    private dwellingService: DwellingService
  ) { }

  ngOnInit(): void {
    this.route.params.subscribe(params => {
      this.dwellingId = params['id'];
      this.getDetalleVivienda();
    });
  }

  getDetalleVivienda(): void {
    this.dwellingService.getOneDwelling(this.dwellingId).subscribe(res => {
      this.dwelling = res;
    });
  }

}
