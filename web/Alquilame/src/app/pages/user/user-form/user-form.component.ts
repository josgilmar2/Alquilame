import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { switchMap } from 'rxjs';
import { ErrorService } from 'src/app/core/services/error.service';
import { UserService } from 'src/app/core/services/user.service';
import { CreateUserDto } from 'src/app/shared/models/dto/user/create_user.dto';
import { EditUserDto } from 'src/app/shared/models/dto/user/edit_user.dto';
import { UserProfile } from 'src/app/shared/models/interfaces/user/user_profile.interface';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-user-form',
  templateUrl: './user-form.component.html',
  styleUrls: ['./user-form.component.css']
})
export class UserFormComponent implements OnInit {

  visibilityPassword: boolean = true;
  visibilityVerifyPassword: boolean = true;
  userToEdit: UserProfile = {} as UserProfile;
  myForm: FormGroup;
  emailPattern: string = "^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$";
  imgUpload!: File;
  imgTemp: any = null;

  constructor(private fb: FormBuilder, private userService: UserService, private activatedRoute: ActivatedRoute, private router: Router, private errorService: ErrorService) {
    this.myForm = this.fb.group({
      username: ['', Validators.required],
      email: ['', [ Validators.required, Validators.pattern(this.emailPattern) ]],
      fullName: ['', Validators.required ],
      phoneNumber: ['', Validators.required],
      address: [''],
      password: ['', [ Validators.required, Validators.minLength(8), ]],
      verifyPassword: ['', [ Validators.required, Validators.minLength(8) ]]
    });
  }

  ngOnInit(): void {
    this.getFormInformation();
  }

  getFormInformation() {
    if(!this.router.url.includes('edit-user')) {
      return;
    }
    this.activatedRoute.params.pipe(
      switchMap(({id}) => this.userService.getOneUser(id))
    )
    .subscribe(res => {
      this.userToEdit = res;
      this.myForm.patchValue({
        fullName: this.userToEdit.fullName,
        phoneNumber: this.userToEdit.phoneNumber,
        address: this.userToEdit.address
      });
    });
  }

  changePasswordVisibility() {
    this.visibilityPassword = !this.visibilityPassword;
  }

  changeVerifyPassworrdVisibility() {
    this.visibilityVerifyPassword = !this.visibilityVerifyPassword;
  }

  submitInquilino() {
    if (this.myForm.valid) {
      this.userService.createInquilino(
        new CreateUserDto(
          this.myForm.get('username')?.value,
          this.myForm.get('email')?.value,
          this.myForm.get('address')?.value,
          this.myForm.get('phoneNumber')?.value,
          this.myForm.get('fullName')?.value,
          this.myForm.get('password')?.value,
          this.myForm.get('verifyPassword')?.value
        )
      )
      .subscribe(res => {
        Swal.fire('¡Creado!', 'Se ha creado el usuario como inquilino correctamente', 'success');
        this.myForm.reset();
      }, (err) => {
        this.errorService.errorsManage(err, '/dashboard/add-user', true);
      });
    } else {
      console.log(this.myForm);
      Swal.fire('Error', 'El formulario no es válido. Inténtelo de nuevo', 'error');
    }
  }

  submitPropietario() {
    if (this.myForm.valid) {
      this.userService.createPropietario(
        new CreateUserDto(
          this.myForm.get('username')?.value,
          this.myForm.get('email')?.value,
          this.myForm.get('address')?.value,
          this.myForm.get('phoneNumber')?.value,
          this.myForm.get('fullName')?.value,
          this.myForm.get('password')?.value,
          this.myForm.get('verifyPassword')?.value
        )
      )
      .subscribe(res => {
        Swal.fire('¡Creado!', 'Se ha creado el usuario como propietario correctamente', 'success');
        this.myForm.reset();
      }, (err) => {
        this.errorService.errorsManage(err, '/dashboard/add-user', true);
      });
    } else {
      console.log(this.myForm);
      Swal.fire('Error', 'El formulario no es válido. Inténtelo de nuevo', 'error');
    }
  }

  submitAdmin() {
    if (this.myForm.valid) {
      this.userService.createAdmin(
        new CreateUserDto(
          this.myForm.get('username')?.value,
          this.myForm.get('email')?.value,
          this.myForm.get('address')?.value,
          this.myForm.get('phoneNumber')?.value,
          this.myForm.get('fullName')?.value,
          this.myForm.get('password')?.value,
          this.myForm.get('verifyPassword')?.value
        )
      )
      .subscribe(res => {
        Swal.fire('¡Creado!', 'Se ha creado el usuario como administrador correctamente', 'success');
        this.myForm.reset();
      }, (err) => {
        this.errorService.errorsManage(err, '/dashboard/add-user', true);
      });
    } else {
      Swal.fire('Error', 'El formulario no es válido. Inténtelo de nuevo', 'error');
    }
  }

  editUser() {
    if(this.userToEdit.id) {
      this.userService.editUser(
        new EditUserDto(
          this.myForm.get('fullName')?.value,
          this.myForm.get('address')?.value,
          this.myForm.get('phoneNumber')?.value,
        ), this.userToEdit.id
      )
      .subscribe(res => {
        Swal.fire('¡Editado!', `Se ha editado a ${this.userToEdit.username} correctamente`, 'success');
        this.getFormInformation();
      }, (err) => {
        this.errorService.errorsManage(err, `/dashboard/edit-user/${this.userToEdit.id}`, true);
      })
    } else {
      Swal.fire('Error', 'El formulario no es válido. Inténtelo de nuevo', 'error');
    }
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

  editAvatar() {
    if(this.userToEdit.id) {
      this.userService.editAvatar(this.imgUpload, this.userToEdit.id).subscribe(res => {
        location.reload();
      }, (err) => {
        this.errorService.errorsManage(err, `/dashboard/edit-user/${this.userToEdit.id}`);
      });
    }
  }

}
