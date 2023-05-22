import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { switchMap } from 'rxjs';
import { DwellingService } from 'src/app/core/services/dwelling.service';
import { ErrorService } from 'src/app/core/services/error.service';
import { ProvinceService } from 'src/app/core/services/province.service';
import { CreateDwellingDto } from 'src/app/shared/models/dto/dwelling/create_dwelling.dto';
import { AllProvinceResponse } from 'src/app/shared/models/interfaces/province/all_provinces_response.interface';
import { OneDwellingResponse } from 'src/app/shared/models/interfaces/dwelling/one_dwelling_response.interface';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-dwelling-form',
  templateUrl: './dwelling-form.component.html',
  styleUrls: ['./dwelling-form.component.css']
})
export class DwellingFormComponent implements OnInit {

  dwellingToEdit: OneDwellingResponse = {} as OneDwellingResponse;
  imgUpload!: File;
  imgTemp: any = null;
  myForm: FormGroup;
  provinces: AllProvinceResponse[] = [];

  constructor(
    private fb: FormBuilder,
    private dwellingService: DwellingService,
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private errorService: ErrorService,
    private provinceService: ProvinceService) {
    this.myForm = this.fb.group({
      name: ['', Validators.required],
      address: ['', Validators.required],
      description: [''],
      type: ['', Validators.required],
      province: ['', Validators.required],
      price: [null, Validators.required],
      m2: [null, Validators.required],
      numBedrooms: [null, Validators.required],
      numBathrooms: [null, Validators.required],
      hasElevator: [false],
      hasPool: [false],
      hasTerrace: [false],
      hasGarage: [false]
    });
  }

  ngOnInit(): void {
    this.getAllProvincias();
    if (!this.router.url.includes('edit-dwelling')) {
      return;
    }
    this.activatedRoute.params.pipe(
      switchMap(({ id }) => this.dwellingService.getOneDwelling(id))
    )
      .subscribe(res => {
        this.dwellingToEdit = res;
        this.myForm.patchValue({
          name: this.dwellingToEdit.name,
          address: this.dwellingToEdit.address,
          description: this.dwellingToEdit.description,
          type: this.dwellingToEdit.type,
          province: this.dwellingToEdit.province,
          price: this.dwellingToEdit.price,
          m2: this.dwellingToEdit.m2,
          numBedrooms: this.dwellingToEdit.numBedrooms,
          numBathrooms: this.dwellingToEdit.numBathrooms,
          hasElevator: this.dwellingToEdit.hasElevator,
          hasPool: this.dwellingToEdit.hasPool,
          hasTerrace: this.dwellingToEdit.hasTerrace,
          hasGarage: this.dwellingToEdit.hasGarage
        });
      });
  }

  changeImage(file: File) {
    this.imgUpload = file;
    if (!file) {
      return this.imgTemp = null;
    }
    const reader = new FileReader();
    reader.readAsDataURL(file);

    return reader.onloadend = () => {
      this.imgTemp = reader.result;
    }
  }

  getAllProvincias() {
    this.provinceService.getAllProvinces().subscribe(res => {
      this.provinces = res;
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard/add-dwelling');
    });
  }

  submitVivienda() {
    if (this.myForm.valid && !this.dwellingToEdit.id) {
      this.dwellingService.createDwelling(
        new CreateDwellingDto(
          this.myForm.get('name')?.value,
          this.myForm.get('address')?.value,
          this.myForm.get('description')?.value,
          this.myForm.get('type')?.value,
          this.myForm.get('price')?.value,
          this.myForm.get('m2')?.value,
          this.myForm.get('numBedrooms')?.value,
          this.myForm.get('numBathrooms')?.value,
          this.myForm.get('hasElevator')?.value,
          this.myForm.get('hasPool')?.value,
          this.myForm.get('hasTerrace')?.value,
          this.myForm.get('hasGarage')?.value,
          this.myForm.get('province')?.value,
        ),
        this.imgUpload
      )
        .subscribe(res => {
          Swal.fire('¡Creado!', 'Se ha creado la vivienda correctamente', 'success');
          this.myForm.reset();
          this.imgTemp = null;
        }, (err) => {
          this.errorService.errorsManage(err, '/dashboard/add-dwelling', true);
        })
    } else {
      this.dwellingService.editDwelling(
        new CreateDwellingDto(
          this.myForm.get('name')?.value,
          this.myForm.get('address')?.value,
          this.myForm.get('description')?.value,
          this.myForm.get('type')?.value,
          this.myForm.get('price')?.value,
          this.myForm.get('m2')?.value,
          this.myForm.get('numBedrooms')?.value,
          this.myForm.get('numBathrooms')?.value,
          this.myForm.get('hasElevator')?.value,
          this.myForm.get('hasPool')?.value,
          this.myForm.get('hasTerrace')?.value,
          this.myForm.get('hasGarage')?.value,
          this.myForm.get('province')?.value,
        ),
        this.imgUpload,
        this.dwellingToEdit.id
      )
      .subscribe(res => {
        Swal.fire('¡Editado!', 'Se ha editado la vivienda correctamente', 'success');
        this.router.navigateByUrl('/dashboard/dwellings'); //TODO: Llevarlo a los detalles
      }, (err) => {
        this.errorService.errorsManage(err, `/dashboard/edit-dwelling/${this.dwellingToEdit.id}`, true);
      });
    }
  }

}
