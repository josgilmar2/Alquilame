package com.salesianostriana.dam.alquilame.exception.rating;

import com.salesianostriana.dam.alquilame.rating.model.RatingPK;

public class RatingNotFoundException extends RuntimeException{

    public RatingNotFoundException(RatingPK id) {
        super(String.format("The user with id %s or the dwelling with id %d could not be found",
                id.getUser_id().toString(), id.getDwelling_id()));
    }

}
