import { Component, OnDestroy } from '@angular/core';
import { ActivationEnd, Router } from '@angular/router';
import { filter, map, Subscription } from 'rxjs';
import { UserService } from 'src/app/core/services/user.service';
import { UserProfile } from '../../models/interfaces/user_profile.interface';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnDestroy {

  titulo: string = '';
  tituloSubs$!: Subscription;
  usuario: UserProfile = {} as UserProfile;

  constructor(private router: Router, private userService: UserService) {
    this.tituloSubs$ = this.getArgumentosRuta().subscribe(({titulo}) => {
      this.titulo = titulo;
      document.title = `Alquilame Admin - ${titulo}`;
    });
  }

  ngOnDestroy(): void {
    this.tituloSubs$.unsubscribe();
  }

  getArgumentosRuta() {
    return this.router.events.pipe(
      filter((event): event is ActivationEnd => event instanceof ActivationEnd),
      filter((event: ActivationEnd) => event.snapshot.firstChild === null),
      map((event: ActivationEnd) => event.snapshot.data)
    );
  }

}
