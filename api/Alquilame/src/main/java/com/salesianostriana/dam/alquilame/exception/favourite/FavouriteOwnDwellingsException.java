package com.salesianostriana.dam.alquilame.exception.favourite;

public class FavouriteOwnDwellingsException extends RuntimeException{

    public FavouriteOwnDwellingsException(Long id) {
        super(String.format("You cannot add the dwelling with id: %d to your favourite list because it's yours.", id));
    }

}
