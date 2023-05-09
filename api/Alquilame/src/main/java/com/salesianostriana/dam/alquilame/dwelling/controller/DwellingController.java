package com.salesianostriana.dam.alquilame.dwelling.controller;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import com.salesianostriana.dam.alquilame.dwelling.dto.DwellingRequest;
import com.salesianostriana.dam.alquilame.dwelling.dto.OneDwellingResponse;
import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.dwelling.service.DwellingService;
import com.salesianostriana.dam.alquilame.page.dto.PageDto;
import com.salesianostriana.dam.alquilame.rating.dto.RatingRequest;
import com.salesianostriana.dam.alquilame.user.model.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.net.URI;

@RestController
@RequestMapping("/dwelling")
@RequiredArgsConstructor
public class DwellingController {

    private final DwellingService dwellingService;

    @Operation(summary = "Obtiene todas las viviendas paginadas")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha obtenido correctamente la lista de viviendas paginadas",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = AllDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                        "id": 53,
                                                        "name": "Estancia Campos De Lino",
                                                        "province": "Guadalajara",
                                                        "image": "chalet.jpeg",
                                                        "price": 803.38
                                                    },
                                                    {
                                                        "id": 54,
                                                        "name": "Piso Acogedor",
                                                        "province": "Caceres",
                                                        "image": "piso.jpeg",
                                                        "price": 450.0
                                                    },
                                                    {
                                                        "id": 55,
                                                        "name": "Casa Los Rodriguez",
                                                        "province": "Murcia",
                                                        "image": "casa.jpeg",
                                                        "price": 1500.94
                                                    },
                                                    {
                                                        "id": 56,
                                                        "name": "Casa Rural",
                                                        "province": "Granada",
                                                        "image": "casa1.jpg",
                                                        "price": 1100.0
                                                    },
                                                    {
                                                        "id": 57,
                                                        "name": "Piso en alquiler en FLOTA DE INDIAS",
                                                        "province": "Sevilla",
                                                        "image": "piso1.jpeg",
                                                        "price": 765.22
                                                    },
                                                    {
                                                        "id": 58,
                                                        "name": "Piso barato en Barcelona",
                                                        "province": "Barcelona",
                                                        "image": "piso2.jpeg",
                                                        "price": 788.51
                                                    },
                                                    {
                                                        "id": 59,
                                                        "name": "Piso en Fotografo Angel Llanos, 14",
                                                        "province": "Pontevedra",
                                                        "image": "piso.jpeg",
                                                        "price": 770.0
                                                    },
                                                    {
                                                        "id": 60,
                                                        "name": "Esmeralda (Chalet adosado en calle Toronga, 11)",
                                                        "province": "Madrid",
                                                        "image": "chalet1.jpeg",
                                                        "price": 2495.6
                                                    },
                                                    {
                                                        "id": 61,
                                                        "name": "Piso en Zapillo",
                                                        "province": "Almeria",
                                                        "image": "piso1.jpeg",
                                                        "price": 550.65
                                                    },
                                                    {
                                                        "id": 62,
                                                        "name": "Chalet independiente en calle de Santa Isabel, 51",
                                                        "province": "Tarragona",
                                                        "image": "chalet2.jpeg",
                                                        "price": 1500.08
                                                    },
                                                    {
                                                        "id": 63,
                                                        "name": "Casa adosado en calle Vicente Trueba, 7",
                                                        "province": "Cantabria",
                                                        "image": "casa1.jpg",
                                                        "price": 1200.44
                                                    },
                                                    {
                                                        "id": 64,
                                                        "name": "Piso en calle medinaceli",
                                                        "province": "Soria",
                                                        "image": "piso.jpeg",
                                                        "price": 900.71
                                                    },
                                                    {
                                                        "id": 65,
                                                        "name": "Estancia Campos De Lino en avenida de Los Recreos",
                                                        "province": "Valladolid",
                                                        "image": "casa2.jpeg",
                                                        "price": 850.19
                                                    },
                                                    {
                                                        "id": 66,
                                                        "name": "Piso en Sagasta",
                                                        "province": "Cadiz",
                                                        "image": "piso2.jpeg",
                                                        "price": 600.14
                                                    },
                                                    {
                                                        "id": 67,
                                                        "name": "El Refugio, Casa en calle Albahaca Nº36",
                                                        "province": "Avila",
                                                        "image": "casa.jpeg",
                                                        "price": 900.77
                                                    },
                                                    {
                                                        "id": 68,
                                                        "name": "Chalet independiente en calle Lamas de Prado, 66 B",
                                                        "province": "Lugo",
                                                        "image": "chalet2.jpeg",
                                                        "price": 420.34
                                                    },
                                                    {
                                                        "id": 69,
                                                        "name": "Casa independiente en calle Naon, 20 A",
                                                        "province": "Asturias",
                                                        "image": "casa.jpeg",
                                                        "price": 650.24
                                                    },
                                                    {
                                                        "id": 70,
                                                        "name": "Chalet independiente en ronda San Cristobal",
                                                        "province": "Navarra",
                                                        "image": "chalet1.jpeg",
                                                        "price": 3000.0
                                                    },
                                                    {
                                                        "id": 71,
                                                        "name": "Piso en calle Orient",
                                                        "province": "Toledo",
                                                        "image": "piso1.jpeg",
                                                        "price": 814.98
                                                    },
                                                    {
                                                        "id": 72,
                                                        "name": "Chalet independiente en calle Junco, 1",
                                                        "province": "Cordoba",
                                                        "image": "chalet2.jpeg",
                                                        "price": 1250.36
                                                    }
                                                ],
                                                "totalElements": 50,
                                                "totalPages": 3,
                                                "number": 0,
                                                "size": 20
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ninguna vivienda",
                    content = @Content)
    })
    @GetMapping("/")
    public PageDto<AllDwellingResponse> getAllDwelling(@RequestParam (value = "search", defaultValue = "") String search,
                                                       @PageableDefault(size = 20) Pageable pageable) {
        return new PageDto<>(dwellingService.findAllDwellings(search, pageable));
    }

    @Operation(summary = "Obtiene una vivienda por su identificador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha obtenido correctamente la vivienda por su identificador",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = OneDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": 53,
                                                "name": "Estancia Campos De Lino",
                                                "province": "Guadalajara",
                                                "image": "chalet.jpeg",
                                                "price": 803.38,
                                                "address": "Torrejon del Rey - Guadalajara",
                                                "description": "Chalet independiente en parcela de 600 metros. Divido en 2 plantas sin escaleras son independientes las 2, la parte de arriba con 3 dormitorios muy amplios con armarios empotrados y maleteros grandes, aire acondicionado con bomba cde calor y calefaccion por gasoil, ventanas de pvc Climalit 10 y mosquiteras, las puertas son de ancho para minusvalidos, para baño. Completo con ventana mosquitera y bañera, cocina completa con mesa y banco 2 ventanas, vitroceramica de induccion, puerta corredera para no entorpecer en la cocina salon con 2 terrazas grande con chimenea. Una de ellas esta cerrada con cerramiento y sirve para habitacion o despacho o q se requiera a gusto de las necesidades de ca uno, tiene mucho sol y vistas al jardin, suelos rusticos. Terraza abierta mas diminuta para tender y da a la piscina y vistas, entrada con una cancela cerrada de aluminio y ventana oscilobatiente y puerta corredera antimosquitos y entrada a la casa con holl amplio q de frente el salon, derecha habitaciones e izda. Cocina. Portero automatico y puerta con motor para meter el coche si uno quiere hay suficiente para aparcar fuera, pero tiene su cochera por si quieres meter motos o bicis. Segunda vivienda las dos miden 150metros cada una. Entras y tienes un salon garaje muy grande con armario, para lavadora o secadora y preparada para poner pila si quieres, cuarto de calderas con deposito 750 litros y tiene espacio para trastos, 2 habitaciones una forrada toda de madera con armario empotrados 3 cuerpos mas maleteros amplios da a la piscina, otro salon muy grande con la cocina tipo isla y chimenea, tiene unas puertas correderas grandes para diferenciar los espacios, luego otra habitacion con puerta corredera aire acondicionado y bomba de calor y baño completo con ventana mosquitera y plato de ducha. Esta para entrar a vivir.",
                                                "type": "CHALET",
                                                "m2": 300.0,
                                                "numBedrooms": 5,
                                                "numBathrooms": 2,
                                                "hasElevator": false,
                                                "hasPool": true,
                                                "hasTerrace": true,
                                                "hasGarage": true,
                                                "owner": {
                                                    "username": "eantoniutti0",
                                                    "fullName": "Elicia Antoniutti",
                                                    "email": "eantoniutti0@furl.net",
                                                    "phoneNumber": "801329286",
                                                    "numPublications": 5
                                                }
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado la vivienda seleccionada",
                    content = @Content)
    })
    @GetMapping("/{id}")
    public OneDwellingResponse getDwellingDetails(@Parameter(description = "Identificador de la vivienda a buscar")
                                                      @PathVariable Long id) {
        Dwelling result = dwellingService.findOneDwelling(id);

        return OneDwellingResponse.of(result);
    }

    @Operation(summary = "Obtener la lista de viviendas paginadas de un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado correctamente la lista de viviendas pagianadas del usuario",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = AllDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                        "id": 53,
                                                        "name": "Estancia Campos De Lino",
                                                        "province": "Guadalajara",
                                                        "image": "chalet.jpeg",
                                                        "price": 803.38
                                                    },
                                                    {
                                                        "id": 54,
                                                        "name": "Piso Acogedor",
                                                        "province": "Caceres",
                                                        "image": "piso.jpeg",
                                                        "price": 450.0
                                                    },
                                                    {
                                                        "id": 55,
                                                        "name": "Casa Los Rodriguez",
                                                        "province": "Murcia",
                                                        "image": "casa.jpeg",
                                                        "price": 1500.94
                                                    },
                                                    {
                                                        "id": 76,
                                                        "name": "Piso en paseo heriz",
                                                        "province": "Guipuzkoa",
                                                        "image": "piso.jpeg",
                                                        "price": 921.43
                                                    },
                                                    {
                                                        "id": 90,
                                                        "name": "Casa independiente en Iñas, cerca centro comercial",
                                                        "province": "A Coruña",
                                                        "image": "casa.jpeg",
                                                        "price": 700.35
                                                    }
                                                ],
                                                "totalElements": 5,
                                                "totalPages": 1,
                                                "number": 0,
                                                "size": 20
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado la lista de viviendas del usuario",
                    content = @Content)
    })
    @GetMapping("/user")
    public PageDto<AllDwellingResponse> getUserDwellings(@AuthenticationPrincipal User user,
                                                         @PageableDefault(size = 20) Pageable pageable) {
        return new PageDto<>(dwellingService.findUserDwellings(user, pageable));
    }

    @Operation(summary = "Creación de una vivienda")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha creado correctamente la vivienda",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = OneDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": 103,
                                                "name": "Chalet Cuqui",
                                                "province": "Sevilla",
                                                "image": "chalet.jpeg",
                                                "price": 563.0,
                                                "address": "C/ Sierpes Nº2, Sevilla",
                                                "description": "Chalet muy chulo que está muy chulo y sigue siendo chulo. Tiene habitaciones chulas y eso :)",
                                                "type": "CHALET",
                                                "m2": 34.0,
                                                "numBedrooms": 3,
                                                "numBathrooms": 1,
                                                "hasElevator": false,
                                                "hasPool": true,
                                                "hasTerrace": true,
                                                "hasGarage": true,
                                                "owner": {
                                                    "username": "eantoniutti0",
                                                    "fullName": "Elicia Antoniutti",
                                                    "email": "eantoniutti0@furl.net",
                                                    "phoneNumber": "80132928",
                                                    "numPublications": 6
                                                }
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha ocurrido algún error al crear la vivienda",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
    })
    @PostMapping("/")
    public ResponseEntity<OneDwellingResponse> createDwelling(@AuthenticationPrincipal User user,
                                                              @Parameter(
                                                                      description = "Files to be uploaded",
                                                                      content = @Content(mediaType = MediaType.APPLICATION_OCTET_STREAM_VALUE)
                                                              ) @RequestPart("file") MultipartFile file,
                                                              @Parameter(description = "Additional request data") @Valid @RequestPart("body") DwellingRequest dto) {
        Dwelling created = dwellingService.createDwelling(dto, user, file);

        URI createdURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(created.getId()).toUri();

        return ResponseEntity.created(createdURI)
                .body(OneDwellingResponse.of(created));
    }

    @Operation(summary = "Edición de una vivienda por su identificador")
    @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = DwellingRequest.class),
                    examples = {@ExampleObject(
                            value = """
                                    {
                                        "name": "Chalet Cuqui",
                                        "address": "C/ Sierpes Nº2, Sevilla",
                                        "description": "Chalet muy chulo que está muy chulo y sigue siendo chulo. Tiene habitaciones chulas y eso :)",
                                        "type": "CHALET",
                                        "price": 563,
                                        "m2": 34,
                                        "numBedrooms": 3,
                                        "numBathrooms": 1,
                                        "hasElevator": true,
                                        "hasPool": false,
                                        "hasTerrace": true,
                                        "hasGarage": false,
                                        "provinceId": 43
                                    }
                                    """
                    )})}
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha editado correctamente la vivienda",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = OneDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": 103,
                                                "name": "Chalet Cuqui",
                                                "province": "Sevilla",
                                                "image": "chalet.jpeg",
                                                "price": 563.0,
                                                "address": "C/ Sierpes Nº2, Sevilla",
                                                "description": "Chalet muy chulo que está muy chulo y sigue siendo chulo. Tiene habitaciones chulas y eso :)",
                                                "type": "CHALET",
                                                "m2": 34.0,
                                                "numBedrooms": 3,
                                                "numBathrooms": 1,
                                                "hasElevator": true,
                                                "hasPool": false,
                                                "hasTerrace": true,
                                                "hasGarage": false,
                                                "owner": {
                                                    "username": "eantoniutti0",
                                                    "fullName": "Elicia Antoniutti",
                                                    "email": "eantoniutti0@furl.net",
                                                    "phoneNumber": "80132928",
                                                    "numPublications": 6
                                                }
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al editar la vivienda",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado la vivienda seleccionada",
                    content = @Content)
    })
    @PutMapping("/{id}")
    @PreAuthorize("@dwellingService.findOneDwelling(#id).user.id == authentication.principal.id")
    public OneDwellingResponse editDwelling(@Parameter(description = "Identificador de la vivienda a editar")
                                                @PathVariable Long id, @Valid @RequestBody DwellingRequest dto,
                                                @AuthenticationPrincipal User user) {
        Dwelling edited = dwellingService.editDwelling(id, dto, user);

        return OneDwellingResponse.of(edited);
    }

    @Operation(summary = "Elimina una vivienda por su identificador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha eliminado correctamente la vivienda seleccionada",
                    content = @Content),
            @ApiResponse(responseCode = "400",
                    description = "La vivienda que se intenta eliminar no pertenece al usuario",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
    })
    @DeleteMapping("/{id}")
    @PreAuthorize("@dwellingService.findOneDwelling(#id).user.id == authentication.principal.id")
    public ResponseEntity<?> deleteDwelling(@Parameter(description = "Identificador de la vivienda a eliminar")
                                                @PathVariable Long id, @AuthenticationPrincipal User user) {
        dwellingService.deleteOneDwelling(id, user);

        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Se añade una vivienda a la lista de favoritos de un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se añade correctamente la vivienda a la lista de favoritos del usuario",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = OneDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": 76,
                                                "name": "Piso en paseo heriz",
                                                "province": "Guipuzkoa",
                                                "image": "piso.jpeg",
                                                "price": 921.43,
                                                "address": "Antiguo, Donostia-San Sebastian",
                                                "description": "En el barrio del Antiguo, en edificio de construccion reciente, alquilamos este caprichooso apartamento. Consta de salon comedor, cocina equipada y dormitorio con amplio armario y baño con ducha incorporado, tipo suite. Se accede a una amplia terraza tanto desde el salon como desde el dormitorio con vistas a la bahia, Monte Igeldo, Isla Santa Clara y Monte Urgul La carpinteria interior es de madera, ventanas climalit y los servicios individuales mediante caldera de gas natural. Dispone de un garaje cerrado motorizado en el mismo edificio de 28 m2. que esta comunicado con la vivienda mediante ascensor. Se solicitan nominas, 1 mes de fianza a depositar ante el gobierno vasco y 2 meses de deposito adicional. Los honorarios de la agencia inmobiliaria son por cuenta del inquilino. No se admiten mascotas.",
                                                "type": "PISO",
                                                "m2": 43.0,
                                                "numBedrooms": 1,
                                                "numBathrooms": 1,
                                                "hasElevator": true,
                                                "hasPool": false,
                                                "hasTerrace": true,
                                                "hasGarage": false,
                                                "owner": {
                                                    "username": "eantoniutti0",
                                                    "fullName": "Elicia Antoniutti",
                                                    "email": "eantoniutti0@furl.net",
                                                    "phoneNumber": "801329286",
                                                    "numPublications": 5
                                                }
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al intentar añadir la vivienda a la lista de favoritos",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
    })
    @PostMapping("/{id}/favourite")
    public ResponseEntity<OneDwellingResponse> markAsFavourite(@Parameter(description = "Identificador de la vivienda a añadir a favoritos")
                                                                   @PathVariable Long id, @AuthenticationPrincipal User user) {
        Dwelling newFavourite = dwellingService.doFavourite(id, user);

        URI createdURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(newFavourite.getId()).toUri();

        return ResponseEntity.created(createdURI)
                .body(OneDwellingResponse.of(newFavourite));
    }

    @Operation(summary = "Elimina una vivienda de la lista de favoritos del usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha eliminado correctamente la vivienda de la lista de favoritos del usuario",
                    content = @Content),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido un error al intentar eliminar la vivienda de la lista de favoritos del usuario",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
    })
    @DeleteMapping("/{id}/favourite")
    public ResponseEntity<?> deleteFavourite(@Parameter(description = "Identificador de la vivienda a eliminar de favoritos")
                                                 @PathVariable Long id, @AuthenticationPrincipal User user) {
        dwellingService.deleteFavourite(id, user);

        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Obtiene todas las viviendas paginadas de una provincia")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha obtenido correctamente la lista de viviendas paginadas de una provincia",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = AllDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                        "id": 57,
                                                        "name": "Piso en alquiler en FLOTA DE INDIAS",
                                                        "province": "Sevilla",
                                                        "image": "piso1.jpeg",
                                                        "price": 765.22
                                                    },
                                                    {
                                                        "id": 73,
                                                        "name": "Piso en calle la Florida, 2",
                                                        "province": "Sevilla",
                                                        "image": "piso2.jpeg",
                                                        "price": 1350.78
                                                    },
                                                    {
                                                        "id": 94,
                                                        "name": "Piso en el Centro",
                                                        "province": "Sevilla",
                                                        "image": "piso1.jpeg",
                                                        "price": 746.91
                                                    },
                                                    {
                                                        "id": 102,
                                                        "name": "Chalet pareado en Av de Europa s/n",
                                                        "province": "Sevilla",
                                                        "image": "chalet2.jpeg",
                                                        "price": 976.19
                                                    }
                                                ],
                                                "totalElements": 4,
                                                "totalPages": 1,
                                                "number": 0,
                                                "size": 20
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado la provincia indicada",
                    content = @Content)
    })
    @GetMapping("/province/{id}")
    public PageDto<AllDwellingResponse> getDwellingsByProvince(@PathVariable Long id,
                                                               @PageableDefault(size = 20) Pageable pageable) {
        return new PageDto<>(dwellingService.findByProvinceId(id, pageable));
    }

    @Operation(summary = "Edita la imagen de una vivienda obtenida por su identificador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha editado correctamente la imagen de la vivienda seleccionada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = OneDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": 103,
                                                "name": "Chalet Cuqui",
                                                "province": "Sevilla",
                                                "image": "chalet1.jpeg",
                                                "price": 563.0,
                                                "address": "C/ Sierpes Nº2, Sevilla",
                                                "description": "Chalet muy chulo que está muy chulo y sigue siendo chulo. Tiene habitaciones chulas y eso :)",
                                                "type": "CHALET",
                                                "m2": 34.0,
                                                "numBedrooms": 3,
                                                "numBathrooms": 1,
                                                "hasElevator": true,
                                                "hasPool": false,
                                                "hasTerrace": true,
                                                "hasGarage": false,
                                                "owner": {
                                                    "username": "eantoniutti0",
                                                    "fullName": "Elicia Antoniutti",
                                                    "email": "eantoniutti0@furl.net",
                                                    "phoneNumber": "801329286",
                                                    "numPublications": 6
                                                }
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al editar la imagen de la vivienda",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado la vivienda de la que se quiere editar su imagen",
                    content = @Content)
    })
    @PutMapping("/{id}/image")
    @PreAuthorize("@dwellingService.findOneDwelling(#id).user.id == authentication.principal.id")
    public OneDwellingResponse editImage(@Parameter(description = "Identificador de la vivienda a la que se le quiere editar la imagen")
                                             @PathVariable Long id,
                                         @RequestPart("file") MultipartFile file,
                                         @AuthenticationPrincipal User user) {
        Dwelling toEditImage = dwellingService.editDwellingImage(id, file, user);

        return OneDwellingResponse.of(toEditImage);
    }

    @Operation(summary = "Elimina una imagen de una vivienda obtenida por su identificador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha eliminado correctamente la imagen de la vivienda seleccionada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = OneDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": 103,
                                                "name": "Chalet Cuqui",
                                                "province": "Sevilla",
                                                "image": null,
                                                "price": 563.0,
                                                "address": "C/ Sierpes Nº2, Sevilla",
                                                "description": "Chalet muy chulo que está muy chulo y sigue siendo chulo. Tiene habitaciones chulas y eso :)",
                                                "type": "CHALET",
                                                "m2": 34.0,
                                                "numBedrooms": 3,
                                                "numBathrooms": 1,
                                                "hasElevator": true,
                                                "hasPool": false,
                                                "hasTerrace": true,
                                                "hasGarage": false,
                                                "owner": {
                                                    "username": "eantoniutti0",
                                                    "fullName": "Elicia Antoniutti",
                                                    "email": "eantoniutti0@furl.net",
                                                    "phoneNumber": "801329286",
                                                    "numPublications": 6
                                                }
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al eliminar la imagen de la vivienda",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado la vivienda de la que se quiere eliminar su imagen",
                    content = @Content)
    })
    @DeleteMapping("/{id}/image")
    @PreAuthorize("@dwellingService.findOneDwelling(#id).user.id == authentication.principal.id")
    public OneDwellingResponse deleteDwellingImage(@Parameter(description = "Identificador de la vivienda a la que se le quiere eliminar la imagen")
                                                       @PathVariable Long id,
                                                   @AuthenticationPrincipal User user) {
        Dwelling toDeleteImage = dwellingService.deleteDwellingImage(id, user);

        return OneDwellingResponse.of(toDeleteImage);
    }

    @PostMapping("/{id}/rate")
    public ResponseEntity<OneDwellingResponse> rateDwelling(@Parameter(description = "Identificador de la vivienda a la que se le quiere eliminar la imagen")
                                                                @PathVariable Long id,
                                                            @AuthenticationPrincipal User user,
                                                            @RequestBody RatingRequest dto) {
        Dwelling newRating = dwellingService.doRating(id, dto, user);

        URI createdURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(newRating.getId()).toUri();

        return ResponseEntity.created(createdURI)
                .body(OneDwellingResponse.of(newRating));
    }

}