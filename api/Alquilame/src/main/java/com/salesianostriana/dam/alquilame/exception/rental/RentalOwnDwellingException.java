package com.salesianostriana.dam.alquilame.exception.rental;

public class RentalOwnDwellingException extends RuntimeException{

    public RentalOwnDwellingException() {
        super(String.format("You cannot rent this dwelling because it's yours"));
    }

}
