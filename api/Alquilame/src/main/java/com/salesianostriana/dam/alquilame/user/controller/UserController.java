package com.salesianostriana.dam.alquilame.user.controller;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import com.salesianostriana.dam.alquilame.page.dto.PageDto;
import com.salesianostriana.dam.alquilame.user.dto.EditPasswordDto;
import com.salesianostriana.dam.alquilame.user.dto.EditUserProfileDto;
import com.salesianostriana.dam.alquilame.user.dto.UserResponse;
import com.salesianostriana.dam.alquilame.user.model.User;
import com.salesianostriana.dam.alquilame.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @Operation(summary = "Obtención de la lista paginada de todos los usuarios")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se han obtenido la lista pagianada de los usuarios correctamente",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                        "id": "2bd9e760-a11e-5d8f-9641-1c54e79c57a1",
                                                        "username": "eantoniutti0",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Elicia Antoniutti",
                                                        "address": "20 Lindbergh Terrace",
                                                        "email": "eantoniutti0@furl.net",
                                                        "phoneNumber": "801329286",
                                                        "numPublications": 5,
                                                        "createdAt": "03/09/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "99ec6bb0-6c98-593c-812b-86ab4de48361",
                                                        "username": "rjersh1",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Rivi Jersh",
                                                        "address": "1360 Burning Wood Park",
                                                        "email": "rjersh1@icq.com",
                                                        "phoneNumber": "210390904",
                                                        "numPublications": 6,
                                                        "createdAt": "25/09/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "3724f1a1-cfed-52ec-b1fa-9c41b6928648",
                                                        "username": "vhame2",
                                                        "avatar": "avatar.jpeg",
                                                        "fullName": "Victor Hame",
                                                        "address": "05 Algoma Alley",
                                                        "email": "vhame2@plala.or.jp",
                                                        "phoneNumber": "949733603",
                                                        "numPublications": 7,
                                                        "createdAt": "28/05/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "0e1d860d-fc9d-5b38-8db0-769b64fdc9f9",
                                                        "username": "msincock3",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Melitta Sincock",
                                                        "address": "4664 Clarendon Hill",
                                                        "email": "msincock3@purevolume.com",
                                                        "phoneNumber": "875943932",
                                                        "numPublications": 0,
                                                        "createdAt": "02/02/2023 00:00:00"
                                                    },
                                                    {
                                                        "id": "60fd46e5-e6a9-5f4f-851e-da2b18aec4af",
                                                        "username": "hwhistlecraft4",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Hilliary Whistlecraft",
                                                        "address": "2 Westerfield Plaza",
                                                        "email": "hwhistlecraft4@privacy.gov.au",
                                                        "phoneNumber": "216159370",
                                                        "numPublications": 0,
                                                        "createdAt": "05/01/2023 00:00:00"
                                                    },
                                                    {
                                                        "id": "ce802e0d-45d6-55ca-90f2-5dc19d03f327",
                                                        "username": "nchaffin5",
                                                        "avatar": "avatar.jpeg",
                                                        "fullName": "Norbie Chaffin",
                                                        "address": "854 Hermina Drive",
                                                        "email": "nchaffin5@loc.gov",
                                                        "phoneNumber": "539210472",
                                                        "numPublications": 8,
                                                        "createdAt": "19/06/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "41c242d6-1921-5ab5-9016-e1fefacd6e20",
                                                        "username": "ndominiak6",
                                                        "avatar": "avatar.jpeg",
                                                        "fullName": "Nikaniki Dominiak",
                                                        "address": "8967 Bunker Hill Circle",
                                                        "email": "ndominiak6@cpanel.net",
                                                        "phoneNumber": "474868723",
                                                        "numPublications": 0,
                                                        "createdAt": "10/11/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "1433977b-5d90-5506-b4f6-d6d6302e5107",
                                                        "username": "mfuncheon7",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Madge Funcheon",
                                                        "address": "335 Victoria Way",
                                                        "email": "mfuncheon7@cocolog-nifty.com",
                                                        "phoneNumber": "674790741",
                                                        "numPublications": 0,
                                                        "createdAt": "15/03/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "de4fab48-c431-54b6-ac87-3d5856774866",
                                                        "username": "cfarran8",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Carmela Farran",
                                                        "address": "087 Vernon Parkway",
                                                        "email": "cfarran8@europa.eu",
                                                        "phoneNumber": "662467301",
                                                        "numPublications": 4,
                                                        "createdAt": "27/12/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "579c921e-0bc0-5142-82ea-b04cceb6dd97",
                                                        "username": "rfassbindler9",
                                                        "avatar": "avatar.jpeg",
                                                        "fullName": "Ranique Fassbindler",
                                                        "address": "44207 Rieder Parkway",
                                                        "email": "rfassbindler9@wikia.com",
                                                        "phoneNumber": "137930609",
                                                        "numPublications": 0,
                                                        "createdAt": "08/07/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "3e35d4f4-7716-54b2-9bdf-805ac4f5b6f0",
                                                        "username": "blahivea",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Beth Lahive",
                                                        "address": "916 Moland Hill",
                                                        "email": "blahivea@goodreads.com",
                                                        "phoneNumber": "779691241",
                                                        "numPublications": 8,
                                                        "createdAt": "08/08/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "6c6f05bc-ec76-5476-ad6e-26a30ee33609",
                                                        "username": "dmckeanb",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Domeniga McKean",
                                                        "address": "921 Artisan Drive",
                                                        "email": "dmckeanb@google.nl",
                                                        "phoneNumber": "912163383",
                                                        "numPublications": 0,
                                                        "createdAt": "30/06/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "7b48e939-d701-5a27-9c92-468c2a534bf8",
                                                        "username": "bslixbyc",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Bonita Slixby",
                                                        "address": "528 Mayfield Crossing",
                                                        "email": "bslixbyc@youtube.com",
                                                        "phoneNumber": "158145460",
                                                        "numPublications": 0,
                                                        "createdAt": "20/04/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "e78192f9-31db-577a-879d-1a1e733f506f",
                                                        "username": "ftustind",
                                                        "avatar": "avatar.jpeg",
                                                        "fullName": "Frederico Tustin",
                                                        "address": "52104 Portage Street",
                                                        "email": "ftustind@imgur.com",
                                                        "phoneNumber": "430315397",
                                                        "numPublications": 0,
                                                        "createdAt": "25/03/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "de39ff65-266c-57ab-8b5f-f8b8aac4534c",
                                                        "username": "draimbaulde",
                                                        "avatar": "avatar.jpeg",
                                                        "fullName": "Darell Raimbauld",
                                                        "address": "37266 Oxford Crossing",
                                                        "email": "draimbaulde@samsung.com",
                                                        "phoneNumber": "601730138",
                                                        "numPublications": 0,
                                                        "createdAt": "18/09/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "75577a8a-c151-528a-ac2f-4273bff9f73d",
                                                        "username": "bbrennanf",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Brena Brennan",
                                                        "address": "88 Morrow Crossing",
                                                        "email": "bbrennanf@addtoany.com",
                                                        "phoneNumber": "838813033",
                                                        "numPublications": 0,
                                                        "createdAt": "28/06/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "a5c05234-df87-5fbf-bc6c-27ceaa162e51",
                                                        "username": "dcarsg",
                                                        "avatar": "avatar.jpeg",
                                                        "fullName": "Dexter Cars",
                                                        "address": "3 Waubesa Circle",
                                                        "email": "dcarsg@sfgate.com",
                                                        "phoneNumber": "524556448",
                                                        "numPublications": 0,
                                                        "createdAt": "20/12/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "f87239fd-e902-5cf7-8e9e-4b85bf5d323d",
                                                        "username": "mornizh",
                                                        "avatar": "avatar.jpeg",
                                                        "fullName": "Marney Orniz",
                                                        "address": "8 Golf Course Way",
                                                        "email": "mornizh@fema.gov",
                                                        "phoneNumber": "471595572",
                                                        "numPublications": 5,
                                                        "createdAt": "15/11/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "5bd0ab0d-7b12-5485-a1c2-83d3d463add8",
                                                        "username": "llahivei",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Lavinia Lahive",
                                                        "address": "4 Manufacturers Point",
                                                        "email": "llahivei@tumblr.com",
                                                        "phoneNumber": "424837938",
                                                        "numPublications": 7,
                                                        "createdAt": "13/02/2022 00:00:00"
                                                    },
                                                    {
                                                        "id": "7ede3dc5-670e-57a7-a5f1-c8c6d15f9b24",
                                                        "username": "rkilcoyne2c",
                                                        "avatar": "avatar2.png",
                                                        "fullName": "Robena Kilcoyne",
                                                        "address": "29 Washington Crossing",
                                                        "email": "rkilcoyne2c@nbcnews.com",
                                                        "phoneNumber": "298295958",
                                                        "numPublications": 0,
                                                        "createdAt": "27/03/2022 00:00:00"
                                                    }
                                                ],
                                                "totalElements": 20,
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
                    description = "No se ha encontrado la lista de usuarios",
                    content = @Content)
    })
    @GetMapping("/")
    public PageDto<UserResponse> getAllUsers(@RequestParam(value = "search", defaultValue = "") String search,
                                              @PageableDefault Pageable pageable) {

        return new PageDto<>(userService.findAllUsers(search, pageable));
    }

    @Operation(summary = "Obtención del perfil del usuario autenticado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha obtenido correctamente el perfil del usuario",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "2bd9e760-a11e-5d8f-9641-1c54e79c57a1",
                                                "username": "eantoniutti0",
                                                "avatar": "avatar2.png",
                                                "fullName": "Elicia Antoniutti",
                                                "address": "20 Lindbergh Terrace",
                                                "email": "eantoniutti0@furl.net",
                                                "phoneNumber": "801329286",
                                                "numPublications": 5,
                                                "createdAt": "03/09/2022 00:00:00"
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
                    description = "El perfil que se quiere obtener pertenece a otro usuario",
                    content = @Content)
    })
    @GetMapping("/profile")
    public UserResponse getMyProfile(@AuthenticationPrincipal User user) {
        User result = userService.myProfile(user);

        return UserResponse.fromUser(result);
    }

    @Operation(summary = "Obtiene todas las viviendas favoritas paginadas del usuario autenticado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha obtenido correctamente la lista de viviendas paginadas del usuario autenticado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = AllDwellingResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "content": [
                                                    {
                                                        "id": 67,
                                                        "name": "El Refugio, Casa en calle Albahaca Nº36",
                                                        "province": "Avila",
                                                        "image": "casa.jpeg",
                                                        "price": 900.77
                                                    }
                                                ],
                                                "totalElements": 1,
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
                    description = "El usuario no tiene ninguna vivienda en su lista de favoritos",
                    content = @Content)
    })
    @GetMapping("/favourites")
    public PageDto<AllDwellingResponse> getFavourites(@AuthenticationPrincipal User user,
                                                      @PageableDefault(size = 20) Pageable pageable) {
        return new PageDto<>(userService.findFavourites(user, pageable));
    }

    @Operation(summary = "Edita el perfil del usuario autenticado")
    @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = EditUserProfileDto.class),
                    examples = {@ExampleObject(
                            value = """
                                    {
                                         "fullName": "José Luis Gil Martín",
                                         "address": "C/ Mi casa Nº2",
                                         "phoneNumber":"654897204",
                                     }
                                    """
                    )})}
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha editado correctamente el perfil del usuario",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "2bd9e760-a11e-5d8f-9641-1c54e79c57a1",
                                                "username": "eantoniutti0",
                                                "avatar": "avatar2.png",
                                                "fullName": "José Luis Gil Martín",
                                                "address": "C/ Mi casa Nº2",
                                                "email": "eantoniutti0@furl.net",
                                                "phoneNumber": "654897204",
                                                "numPublications": 5,
                                                "createdAt": "03/09/2022 00:00:00"
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al editar el usuario",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado al usuario para editar su perfil",
                    content = @Content)
    })
    @PutMapping("/")
    public UserResponse editProfile(@Valid @RequestBody EditUserProfileDto dto, @AuthenticationPrincipal User user) {
        User toEdit = userService.edit(dto, user);

        return UserResponse.fromUser(toEdit);
    }

    @Operation(summary = "Eliminar un usuario autenticado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha eliminado correctamente el perfil del usuario",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
    })
    @DeleteMapping("/delete")
    @PreAuthorize("@userService.myProfile(#user).id == authentication.principal.id")
    public ResponseEntity<?> deleteProfile(@AuthenticationPrincipal User user) {
        userService.delete(user);

        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Edición de la contraseña del usuario autenticado")
    @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = EditPasswordDto.class),
                    examples = {@ExampleObject(
                            value = """
                                    {
                                        "oldPassword": "Eu57ESbiU",
                                        "newPassword": "GHyuIopR5.",
                                        "verifyNewPassword": "GHyuIopR5."
                                    }
                                    """
                    )})}
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha editado correctamente la contraseña del usuario autenticado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "2bd9e760-a11e-5d8f-9641-1c54e79c57a1",
                                                "username": "eantoniutti0",
                                                "avatar": "avatar2.png",
                                                "fullName": "Elicia Antoniutti",
                                                "address": "20 Lindbergh Terrace",
                                                "email": "eantoniutti0@furl.net",
                                                "phoneNumber": "801329286",
                                                "numPublications": 5,
                                                "createdAt": "03/09/2022 00:00:00"
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha ocurrido algún error al editar la contraseña",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado al usuario para editar su contraseña",
                    content = @Content)
    })
    @PutMapping("/changePassword")
    @PreAuthorize("@userService.myProfile(#user).id == authentication.principal.id")
    public UserResponse editPassword(@Valid @RequestBody EditPasswordDto dto, @AuthenticationPrincipal User user) {
        User toEditPassword = userService.editPassword(dto, user);

        return UserResponse.fromUser(toEditPassword);
    }

    @Operation(summary = "Edita del avatar del usuario autenticado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha editado correctamente el avatar del usuario autenticado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "2bd9e760-a11e-5d8f-9641-1c54e79c57a1",
                                                "username": "eantoniutti0",
                                                "avatar": "avatar2.png",
                                                "fullName": "Elicia Antoniutti",
                                                "address": "20 Lindbergh Terrace",
                                                "email": "eantoniutti0@furl.net",
                                                "phoneNumber": "801329286",
                                                "numPublications": 5,
                                                "createdAt": "03/09/2022 00:00:00"
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al editar el avatar del usuario autenticado",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado el usaurio al que se quiere editar su avatar",
                    content = @Content)
    })
    @PutMapping("/changeAvatar")
    @PreAuthorize("@userService.myProfile(#user).id == authentication.principal.id")
    public UserResponse editAvatar(@RequestPart("file") MultipartFile file, @AuthenticationPrincipal User user) {
        User toEditAvatar = userService.editAvatar(file, user);

        return UserResponse.fromUser(toEditAvatar);
    }

    @Operation(summary = "Elimina el avatar del usuario autenticado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha eliminado correctamente el avatar del usuario autenticado",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "2bd9e760-a11e-5d8f-9641-1c54e79c57a1",
                                                "username": "eantoniutti0",
                                                "avatar": null,
                                                "fullName": "Elicia Antoniutti",
                                                "address": "20 Lindbergh Terrace",
                                                "email": "eantoniutti0@furl.net",
                                                "phoneNumber": "801329286",
                                                "numPublications": 5,
                                                "createdAt": "03/09/2022 00:00:00"
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al eliminar el avatar del usuario autenticado",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "No tienes aurorización para realizar esta petición",
                    content = @Content),
            @ApiResponse(responseCode = "403",
                    description = "Se ha expirado el token JWT o no tienes acceso para realizar esta petición debido a tu rol",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado el usaurio al que se quiere eliminar su avatar",
                    content = @Content)
    })
    @DeleteMapping("/deleteAvatar")
    @PreAuthorize("@userService.myProfile(#user).id == authentication.principal.id")
    public UserResponse deleteAvatar(@AuthenticationPrincipal User user) {
        User toDeleteAvatar = userService.deleteAvatar(user);

        return UserResponse.fromUser(toDeleteAvatar);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUserByAdmin(@PathVariable UUID id) {
        userService.deleteUserByAdmin(id);

        return ResponseEntity.noContent().build();
    }

    @PutMapping("/ban/{id}")
    public UserResponse banUser(@PathVariable UUID id) {
        User toBan = userService.banUser(id);

        return UserResponse.fromUser(toBan);
    }

    @PutMapping("/unban/{id}")
    public UserResponse unbanUser(@PathVariable UUID id) {
        User toUnban = userService.unbanUser(id);

        return UserResponse.fromUser(toUnban);
    }

    @GetMapping("/{id}")
    public UserResponse getOneUser(@PathVariable UUID id) {
        User user = userService.findOneUser(id);

        return UserResponse.fromUser(user);
    }

    @PutMapping("/{id}")
    public UserResponse editUserByAdmin(@Valid @RequestBody EditUserProfileDto dto, @PathVariable UUID id) {
        User user = userService.editUserByAdmin(dto, id);

        return UserResponse.fromUser(user);
    }

    @PutMapping("/{id}/changeAvatar")
    public UserResponse editUserAvatarByAdmin(@RequestPart("file") MultipartFile file, @PathVariable UUID id) {
        User toEditAvatar = userService.editAvatarByAdmin(file, id);

        return UserResponse.fromUser(toEditAvatar);
    }

    @GetMapping("/number")
    public int usersNumber() {
        return userService.usersNumbers();
    }

}
