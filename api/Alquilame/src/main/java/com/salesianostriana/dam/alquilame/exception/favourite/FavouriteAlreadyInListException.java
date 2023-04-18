package com.salesianostriana.dam.alquilame.exception.favourite;

public class FavouriteAlreadyInListException extends RuntimeException{

    public FavouriteAlreadyInListException(Long id, String username) {
        super(String.format("The dwelling with id: %d is already in the favourite list of user %s", id, username));
    }

}
