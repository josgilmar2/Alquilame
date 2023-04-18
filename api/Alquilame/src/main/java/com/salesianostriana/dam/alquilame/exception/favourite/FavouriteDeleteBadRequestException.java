package com.salesianostriana.dam.alquilame.exception.favourite;

public class FavouriteDeleteBadRequestException extends RuntimeException{

    public FavouriteDeleteBadRequestException(Long id) {
        super(String.format("You cannot delete the dwelling with id %d because it isn't in your favourite list", id));
    }

}
