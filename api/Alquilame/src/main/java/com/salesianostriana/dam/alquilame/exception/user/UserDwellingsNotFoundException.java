package com.salesianostriana.dam.alquilame.exception.user;

public class UserDwellingsNotFoundException extends RuntimeException{

    public UserDwellingsNotFoundException(String username) {
        super(String.format("No dwellings were found for user: %s", username));
    }

}
