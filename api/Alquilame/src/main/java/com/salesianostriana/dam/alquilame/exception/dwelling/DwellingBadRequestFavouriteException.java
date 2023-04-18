package com.salesianostriana.dam.alquilame.exception.dwelling;

public class DwellingBadRequestFavouriteException extends RuntimeException{

    public DwellingBadRequestFavouriteException(Long id) {
        super(String.format("The dwelling with id: %d doesn't exists", id));
    }

}
