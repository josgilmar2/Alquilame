package com.salesianostriana.dam.alquilame.security.jwt.access;

import com.salesianostriana.dam.alquilame.exception.jwt.JwtTokenException;
import com.salesianostriana.dam.alquilame.user.model.User;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.crypto.SecretKey;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.UUID;

@Service
public class JwtProvider {

    public static final String TOKEN_TYPE = "JWT";
    public static final String TOKEN_HEADER = "Authorization";
    public static final String TOKEN_PREFIX = "Bearer ";

    @Value("${jwt.secret}")
    private String jwtSecret;

    @Value("${jwt.duration}")
    private int jwtLifeInMinutes;

    private JwtParser jwtParser;
    private SecretKey secretKey;

    @PostConstruct
    public void init() {
        secretKey = Keys.hmacShaKeyFor(jwtSecret.getBytes());
        jwtParser = Jwts.parserBuilder()
                .setSigningKey(secretKey)
                .build();
    }

    public String generateToken(Authentication authentication) {
        User user = (User) authentication.getPrincipal();

        return generateToken(user);
    }

    public String generateToken(User user) {
        Date tokenExpirationDay = Date.from(LocalDateTime
                .now()
                .plusMinutes(jwtLifeInMinutes)
                .atZone(ZoneId.systemDefault())
                .toInstant()
        );
        return Jwts.builder()
                .setHeaderParam("typ", TOKEN_TYPE)
                .setSubject(user.getId().toString())
                .setIssuedAt(new Date())
                .setExpiration(tokenExpirationDay)
                .signWith(secretKey)
                .compact();
    }

    public UUID getUserIdFromJwtToken(String token) {
        return UUID.fromString(
                jwtParser.parseClaimsJws(token).getBody().getSubject()
        );
    }

    public boolean validateToken(String token) {
        try {
            jwtParser.parseClaimsJws(token);
            return true;
        } catch (SignatureException | MalformedJwtException | ExpiredJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
            throw new JwtTokenException(ex.getMessage());
        }
    }

}
