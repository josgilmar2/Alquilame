package com.salesianostriana.dam.alquilame.exception.rating;

public class AlreadyRatedException extends RuntimeException{

    public AlreadyRatedException(Long id) {
        super(String.format("You just have rated the dwelling with id: %d", id));
    }

}
