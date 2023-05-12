import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/core/services/user.service';
import { User } from 'src/app/shared/models/interfaces/all_user_response.interface';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {

  usuarios: User[] = []
  page: number = 0;
  totalPages: number = 0;
  message: string = '';

  constructor(private userService: UserService) { }

  ngOnInit(): void {
    this.userService.getAllUsers(this.page).subscribe(res => {
      this.usuarios = res.content;
      this.totalPages = res.totalPages;
    });
  }

  pageBefore() {
    if (this.page > 0) {
      this.page = this.page - 1;
      this.userService.getAllUsers(this.page).subscribe(res => {
        this.usuarios = res.content;
      });
    }
  }

  pageNext() {
    if(this.page < this.totalPages) {
      this.page = this.page + 1;
      this.userService.getAllUsers(this.page).subscribe(res => {
        this.usuarios = res.content;
      });
    }
  }

}
