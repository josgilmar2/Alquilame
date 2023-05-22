import { Component, OnInit } from '@angular/core';
import { ErrorService } from 'src/app/core/services/error.service';
import { UserService } from 'src/app/core/services/user.service';
import { User } from 'src/app/shared/models/interfaces/user/all_user_response.interface';
import { UserProfile } from 'src/app/shared/models/interfaces/user/user_profile.interface';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-users',
  templateUrl: './users-list.component.html',
  styleUrls: ['./users-list.component.css']
})
export class UsersListComponent implements OnInit {

  cargando: boolean = true;
  usuarios: User[] = []
  page: number = 0;
  totalPages: number = 0;
  pagesNumber: number[] = [];
  message: string = '';
  usuarioDelete: UserProfile = {} as UserProfile;
  usuarioBan: UserProfile = {} as UserProfile;

  constructor(private userService: UserService, private errorService: ErrorService) { }

  ngOnInit(): void {
    this.getAllUsuarios();
  }

  getAllUsuarios() {
    this.cargando = true;
    this.userService.getAllUsers(this.page).subscribe(res => {
      this.cargando = false;
      this.usuarios = res.content;
      this.totalPages = res.totalPages;
      this.pagesNumber = Array.from({ length: this.totalPages }, (_, index) => index + 1);
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard/users');
    });
  }

  pageBefore() {
    if (this.page > 0) {
      this.page = this.page - 1;
      this.getAllUsuarios();
    }
  }

  pageNext() {
    if (this.page < this.totalPages) {
      this.page = this.page + 1;
      this.getAllUsuarios();
    }
  }

  pageSelected(pageNumber: number) {
    this.page = pageNumber;
    this.getAllUsuarios();
  }

  usuarioAEliminar(user: UserProfile) {
    this.usuarioDelete = user;
  }

  usuarioABanear(user: UserProfile) {
    this.usuarioBan = user;
    if (this.usuarioBan.enabled) {
      Swal.fire({
        title: `Esta a punto de banear a ${this.usuarioBan.username}.`,
        text: "La acción no podrá revertirse. ¿Estás seguro de que quieres banear a este usuario?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Ban'
      }).then((result) => {
        if (result.isConfirmed) {
          this.userService.banUser(this.usuarioBan.id!).subscribe((res) => {
          }, (err) => {
            this.errorService.errorsManage(err, '/dashboard/users');
          });
          location.reload();
        }
      })
    } else {
      Swal.fire({
        title: `Esta a punto de desbanear a ${this.usuarioBan.username}.`,
        text: "La acción no podrá revertirse. ¿Estás seguro de que quieres desbanear a este usuario?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Unban'
      }).then((result) => {
        if (result.isConfirmed) {
          this.userService.unbanUser(this.usuarioBan.id!).subscribe((res) => {
          }, (err) => {
            this.errorService.errorsManage(err, '/dashboard/users');
          });
          location.reload();
        }
      });
    }
  }

  borrarUsuario() {
    this.userService.deleteUser(this.usuarioDelete.id!).subscribe((res) => {
      location.reload();
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard/users');
    })
  }

  buscarUsuario(termino: string) {
    if (termino.trim().length === 0) {
      return this.getAllUsuarios();
    }
    return this.userService.searchUser(termino).subscribe(res => {
      this.usuarios = res.content;
    });
  }

}
