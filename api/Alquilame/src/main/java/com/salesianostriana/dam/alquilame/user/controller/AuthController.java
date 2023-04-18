package com.salesianostriana.dam.alquilame.user.controller;

import com.salesianostriana.dam.alquilame.security.jwt.JwtProvider;
import com.salesianostriana.dam.alquilame.user.dto.CreateUserDto;
import com.salesianostriana.dam.alquilame.user.dto.LoginResponse;
import com.salesianostriana.dam.alquilame.user.dto.LoginRequest;
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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.net.URI;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;

    @Operation(summary = "creación de un nuevo inquilino")
    @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = {@Content(mediaType = "application/json",
                schema = @Schema(implementation = CreateUserDto.class),
                examples = {@ExampleObject(
                        value = """
                                {
                                    "username": "user2",
                                    "email": "admin@yahoo.com",
                                    "address": "C/ Mi Casa Nº2",
                                    "phoneNumber": "678956782",
                                    "fullName": "Luismi López",
                                    "password": "DFGhjkl.3",
                                    "verifyPassword": "DFGhjkl.3"
                                }
                                """
                )})}
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha creado correctamente el nuevo usuario con rol de inquilino",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "c0a80135-865c-17ab-8186-5c8bf18b0000",
                                                "username": "user2",
                                                "avatar": "avatar_164275.jpeg",
                                                "fullName": "Luismi López",
                                                "address": "C/ Mi Casa Nº2",
                                                "email": "admin@yahoo.com",
                                                "phoneNumber": "678956782",
                                                "numPublications": 0,
                                                "createdAt": "17/02/2023 00:25:20"
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al intentar crear al nuevo usuario con rol de inquilino",
                    content = @Content)
    })
    @PostMapping("/register/inquilino")
    public ResponseEntity<UserResponse> createUserWithInquilinoRole(@Valid @RequestBody CreateUserDto dto) {
        User user = userService.createUserWithInquilinoRole(dto);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(UserResponse.fromUser(user));
    }

    @Operation(summary = "creación de un nuevo inquilino")
    @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = CreateUserDto.class),
                    examples = {@ExampleObject(
                            value = """
                                {
                                    "username": "user1",
                                    "email": "admin@google.com",
                                    "address": "C/ Mi Casa Nº2",
                                    "phoneNumber": "639856235",
                                    "fullName": "Luismi López",
                                    "password": "DFGhjkl.3",
                                    "verifyPassword": "DFGhjkl.3"
                                }
                                """
                    )})}
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha creado correctamente el nuevo usuario con rol de propietario",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserResponse.class),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "id": "c0a80135-865c-17ab-8186-5c8bf18b0000",
                                                "username": "user1",
                                                "avatar": "avatar.jpeg",
                                                "fullName": "Luismi López",
                                                "address": "C/ Mi Casa Nº2",
                                                "email": "admin@google.com",
                                                "phoneNumber": "698563214",
                                                "numPublications": 0,
                                                "createdAt": "17/02/2023 00:25:20"
                                            }
                                            """
                            )})}),
            @ApiResponse(responseCode = "400",
                    description = "Ha habido algún error al intentar crear al nuevo usuario con rol de propietario",
                    content = @Content)
    })
    @PostMapping("/register/propietario")
    public ResponseEntity<UserResponse> createUserWithPropietarioRole(@Valid @RequestBody CreateUserDto dto) {
        User user = userService.createUSerWitPropietarioRole(dto);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(UserResponse.fromUser(user));
    }

    @Operation(summary = "Endpoint para realizar el login de un usuario")
    @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = {@Content(mediaType = "application/json",
                    schema = @Schema(implementation = LoginRequest.class),
                    examples = {@ExampleObject(
                            value = """
                                    {
                                        "username": "eantoniutti0",
                                        "password": "Eu57ESbiU"
                                    }
                                    """
                    )})}
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                content = {@Content(mediaType = "application/json",
                        schema = @Schema(implementation = LoginResponse.class),
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
                                            "createdAt": "03/09/2022 00:00:00",
                                            "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyYmQ5ZTc2MC1hMTFlLTVkOGYtOTY0MS0xYzU0ZTc5YzU3YTEiLCJpYXQiOjE2NzY1MzgzMzAsImV4cCI6MTY3NjUzODM5MH0.dfgwlXI0yPKfQ2h5EU8cjmY48esmBIryLTqEV6U4UxWjdCGYw5VBCcNke1WutComGbj0NltJaBfMqcucUEp5Vg"
                                        }
                                        """
                        )})}),
            @ApiResponse(responseCode = "401",
                    description = "Las credenciales que se han introducido son erróneas",
                    content = @Content)
    })
    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest dto) {
        Authentication authentication =
                authManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                dto.getUsername(),
                                dto.getPassword()
                        )
                );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        User user = (User) authentication.getPrincipal();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(LoginResponse.of(user, token));
    }

}
