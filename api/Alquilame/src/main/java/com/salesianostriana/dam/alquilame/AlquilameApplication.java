package com.salesianostriana.dam.alquilame;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import io.swagger.v3.oas.annotations.media.Content;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

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

	@Bean
	public WebMvcConfigurer corsConfigurer()
	{
		String[] allowDomains = new String[2];
		allowDomains[0] = "http://localhost:4200";
		allowDomains[1] = "http://localhost:8080";

		System.out.println("CORS configuration....");
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**").allowedMethods("*").allowedOrigins(allowDomains);
			}
		};
	}

}
