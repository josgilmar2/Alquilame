package com.salesianostriana.dam.alquilame.security;

import com.salesianostriana.dam.alquilame.security.jwt.access.JwtAuthenticationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationEntryPoint jwtAuthenticationEntryPoint;
    private final AccessDeniedHandler jwtAccessDeniedHandler;
    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {

        AuthenticationManagerBuilder authenticationManagerBuilder =
                http.getSharedObject(AuthenticationManagerBuilder.class);

        AuthenticationManager authenticationManager =
                authenticationManagerBuilder.authenticationProvider(authenticationProvider())
                        .build();

        return authenticationManager;
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();

        authenticationProvider.setUserDetailsService(userDetailsService);
        authenticationProvider.setPasswordEncoder(passwordEncoder);
        authenticationProvider.setHideUserNotFoundExceptions(false);

        return authenticationProvider;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(Customizer.withDefaults())
                .csrf().disable()
                        .exceptionHandling()
                                .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                                .accessDeniedHandler(jwtAccessDeniedHandler)
                        .and()
                                .sessionManagement()
                                    .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                        .and()
                                .authorizeRequests()
                                .antMatchers(HttpMethod.POST, "/dwelling/").hasAnyRole("PROPIETARIO", "ADMIN")
                                .antMatchers(HttpMethod.PUT, "/dwelling/**").hasAnyRole("PROPIETARIO", "ADMIN")
                                .antMatchers(HttpMethod.DELETE, "/dwelling/{id}").hasAnyRole("PROPIETARIO", "ADMIN")
                                .antMatchers("/dwelling/**").hasAnyRole("PROPIETARIO", "INQUILINO", "ADMIN")
                                .antMatchers("/user/number", "user/ban/**", "/user/unban/**").hasRole("ADMIN")
                                .antMatchers(HttpMethod.DELETE, "/user/{id}").hasRole("ADMIN")
                                .antMatchers(HttpMethod.PUT, "/user/{id}/**").hasRole("ADMIN")
                                .antMatchers("/user/admins").hasRole("ADMIN")
                                .antMatchers("/user/**").hasAnyRole("PROPIETARIO", "INQUILINO", "ADMIN")
                                .antMatchers("/auth/register/admin").hasRole("ADMIN")
                                .antMatchers(HttpMethod.POST, "/province/**").hasRole("ADMIN")
                                .antMatchers(HttpMethod.PUT, "/province/**").hasRole("ADMIN")
                                .antMatchers(HttpMethod.DELETE, "/province/**").hasRole("ADMIN")
                                .antMatchers("/province/**").hasAnyRole("PROPIETARIO", "INQUILINO", "ADMIN")
                                .antMatchers("/rental/totalSales").hasRole("ADMIN")
                                .antMatchers("/rental/**").hasAnyRole("PROPIETARIO", "INQUILINO", "ADMIN")
                                .antMatchers("/creditcard/**").hasAnyRole("PROPIETARIO", "INQUILINO", "ADMIN")
                                .antMatchers("/ranking/**").hasRole("ADMIN")
                                .anyRequest().permitAll();

        http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        http.headers().frameOptions().disable();

        return http.build();
    }

    /*@Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("*"));
        configuration.setAllowedMethods(Arrays.asList("GET","POST", "PUT", "DELETE", "OPTIONS"));
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }*/


    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web -> web.ignoring().antMatchers("/h2-console/**", "/auth/register/propietario", "/auth/register/inquilino", "/auth/login", "auth/refreshtoken", "/swagger-ui/**", "/v3/api-docs/**", "/download/**"));
    }

}
