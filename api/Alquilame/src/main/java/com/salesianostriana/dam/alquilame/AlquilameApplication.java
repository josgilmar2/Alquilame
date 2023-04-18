package com.salesianostriana.dam.alquilame;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import io.swagger.v3.oas.annotations.media.Content;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@OpenAPIDefinition(info =
@Info(description = "API que consume la aplicación Alquilame que gestiona alquileres de viviendas",
		version = "1.0",
		contact = @Contact(email = "gil.majos22@triana.salesianos.edu", name = "José Luis Gil Martín"),
		license = @License(name = "Salesianos Triana"),
		title = "Alquilame")
)
public class AlquilameApplication {

	public static void main(String[] args) {
		SpringApplication.run(AlquilameApplication.class, args);
	}

}
