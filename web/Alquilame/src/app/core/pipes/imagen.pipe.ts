import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'imagen'
})
export class ImagenPipe implements PipeTransform {

  transform(avatar: string): string {
    const urlBase = 'http://localhost:8080'
    if(!avatar) {
      return 'https://simulacionymedicina.es/wp-content/uploads/2015/11/default-avatar-300x300-1.jpg';
    } else if (avatar) {
      return `${urlBase}/download/${avatar}`;
    } else {
      return 'https://simulacionymedicina.es/wp-content/uploads/2015/11/default-avatar-300x300-1.jpg';
    }
  }

}
