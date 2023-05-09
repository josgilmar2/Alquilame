package com.salesianostriana.dam.alquilame.exception.rating;

public class RatingOwnDwellingException extends RuntimeException {

    public RatingOwnDwellingException(Long id) {
        super(String.format("You cannot rate the dwelling with id: %d because it's yours.", id));
    }

}
