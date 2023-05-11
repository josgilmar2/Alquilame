import { Component, Input, OnInit } from '@angular/core';
import { SidenavService } from 'src/app/core/services/sidenav.service';

@Component({
  selector: 'app-sidenav',
  templateUrl: './sidenav.component.html',
  styleUrls: ['./sidenav.component.css']
})
export class SidenavComponent implements OnInit {

  @Input() isSidenavVisible: boolean = false;

  constructor(public sidenavService: SidenavService) { }

  ngOnInit(): void {
  }

}
