package com.salesianostriana.dam.alquilame.exception.favourite;

public class FavouriteNotFoundException extends RuntimeException{

    public FavouriteNotFoundException(String username) {
        super(String.format("User with username: %s, hasn't any favourite dwelling.", username));
    }


}
