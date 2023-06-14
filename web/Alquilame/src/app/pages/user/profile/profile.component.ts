import { Component, OnInit } from '@angular/core';
import { ErrorService } from 'src/app/core/services/error.service';
import { UserService } from 'src/app/core/services/user.service';
import { UserProfile } from 'src/app/shared/models/interfaces/user/user_profile.interface';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  profile: UserProfile = {} as UserProfile;
  admins: UserProfile[] = [];

  constructor(private userService: UserService, private errorService: ErrorService) { }

  ngOnInit(): void {
    this.getUserProfile();
  }

  getUserProfile() {
    this.userService.getProfile().subscribe(res => {
      this.profile = res;
    }, (err) => {
      this.errorService.errorsManage(err, '/dashboard/profile');
    });
  }

}
