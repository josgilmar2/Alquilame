import { Component, Input, OnInit } from '@angular/core';
import { AuthService } from 'src/app/core/services/auth.service';
import { SidenavService } from 'src/app/core/services/sidenav.service';

@Component({
  selector: 'app-sidenav',
  templateUrl: './sidenav.component.html',
  styleUrls: ['./sidenav.component.css']
})
export class SidenavComponent implements OnInit {

  @Input() isSidenavVisible: boolean = false;

  constructor(public sidenavService: SidenavService, private authService: AuthService) { }

  ngOnInit(): void {
  }

  logout(item: any) {
    if(item.tiulo === 'Logout') {
      this.authService.logout();
    }

  }

}
