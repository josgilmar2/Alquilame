import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'imagen'
})
export class ImagenPipe implements PipeTransform {

  transform(imagen: string): unknown {
    const urlBase = 'http://localhost:8080'
    if(!imagen) {
      return 'https://areajugones.sport.es/wp-content/uploads/2020/12/zoneri-021-headquarters-garrison.jpg';
    } else if (imagen) {
      return `${urlBase}/download/${imagen}`;
    } else {
      return 'https://areajugones.sport.es/wp-content/uploads/2020/12/zoneri-021-headquarters-garrison.jpg';
    }
  }

}
