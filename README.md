# Alquilame

<p align="center">
  <a href="https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html"><img src="https://img.shields.io/badge/jdk-v17.0.4.1-blue" alt="Versión java" /></a>
  <a href="https://maven.apache.org/download.cgi"><img src="https://img.shields.io/badge/apache--maven-v3.8.6-blue" alt="Versión maven" /></a>
  <a href="https://spring.io/projects/spring-boot"><img src="https://img.shields.io/badge/spring--boot-v2.7.8-green" alt="Versión spring-boot" /></a>
  <a href="https://dart.dev/"><img src="https://img.shields.io/badge/dart-v3.0.0-blue" alt="Versión dart" /></a>
  <a href="https://flutter.dev/"><img src="https://img.shields.io/badge/flutter-3.8.0--13.0.pre.95-blue" alt="Versión flutter" /></a>
  <a href="https://angular.io/"><img src="https://img.shields.io/badge/angular-v14.2-red" alt="Versión angular"></a>
  <a href="https://nodejs.org/es"><img src="https://img.shields.io/badge/node-v16.17.1-yellowgreen" alt="Versión node"></a>
  <a href="https://www.npmjs.com/"><img src="https://img.shields.io/badge/npm-v8.15.0-red" alt="Versión npm"></a>
  <img src="https://img.shields.io/badge/release%20date-february-yellowgreen" alt="Lanzamiento del proyecto" />
  <img src="https://img.shields.io/badge/license-MIT-brightgreen" alt="Licencia" />
</p>

## Descripción
Alquilame es una aplicación de alquiler de viviendas que consta de una API en *Spring Boot*, un frontend en *Angular* y otro frontend en *Flutter*. La aplicación permite a diferentes usuarios alquilar viviendas o publicar y alquilar propiedades según su rol. Los usuarios con rol de **INQUILINO** solo pueden alquilar viviendas, mientras que los usuarios con rol de **PROPIETARIO** pueden publicar y alquilar propiedades. Además, Alquilame cuenta con una página administrativa en Angular que permite a los usuarios con rol de **ADMIN** realizar diversas funcionalidades de administración, como eliminar viviendas o usuarios, bloquear usuarios, editar viviendas o usuarios, entre otras.

## Configuración

### Requisitos previos
- Docker y Docker Compose instalados en el sistema.
- Flutter SDK instalado en el sistema.

### Pasos para la configuración

1. Clona el repositorio de Alquilame desde GitHub:

```console
git clone https://github.com/josgilmar2/Alquilame.git
```

2. Para ejecutar la API de Spring Boot y la aplicación de Angular, abre una terminal, ve al directorio raíz del proyecto clonado y ejecuta el siguiente comando:

```console
docker compose up -d
```

Este comando iniciará los contenedores de Docker para la API y el frontend de Angular como un PgAdmin para poder ver los datos importados de prueba.

3. Para ejecutar la aplicación de Flutter, abre otra terminal y navega hasta el directorio `./mobile/alquilame` dentro del proyecto clonado. A continuación, ejecuta el siguiente comando:

```console
flutter run
```

Este comando iniciará la aplicación de Flutter en un simulador o dispositivo conectado.

4. Dependiendo del tipo de simulador que estés utilizando en Flutter, asegúrate de tener configurada correctamente la URL base en el archivo `./lib/rest/rest_client.dart`. Si estás utilizando un simulador iOS, la URL base debe ser:

```dart
static String baseUrl = "http://localhost:8080";
```

Si estás utilizando un simulador Android, la URL base debe ser:

```dart
static String baseUrl = "http://10.0.2.2:8080";
```

Una vez completados estos pasos, la aplicación Alquilame debería estar en funcionamiento y lista para ser probada.

## Contribución

Si deseas contribuir al desarrollo de Alquilame, sigue los pasos a continuación:

1. Crea un fork del repositorio Alquilame en tu cuenta de GitHub.

2. Clona tu fork del repositorio en tu máquina local:

```bash
git clone https://github.com/josgilmar2/Alquilame.git
```

3. Crea una rama de características a partir de la rama principal:

```bash
git checkout -b nombre-rama
```

4. Realiza los cambios y mejoras en el código.

5. Haz commit de tus cambios:

```bash
git commit -m "Descripción de los cambios"
```

6. Sube los cambios a tu repositorio remoto:
```bash
git push origin nombre-rama
```

7. Crea una solicitud de extracción en el repositorio original de Alquilame, comparando tu rama de características con la rama principal.

8. Espera a que se revise y apruebe tu solicitud de extracción. Una vez aprobada, tus cambios serán fusionados con el repositorio principal.

¡Gracias por contribuir a Alquilame!

## Licencia

Este proyecto está licenciado bajo la Licencia MIT.
Recuerda reemplazar `josgilmar2` por tu nombre de usuario de GitHub en el enlace de clonación.