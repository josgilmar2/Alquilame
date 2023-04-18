package com.salesianostriana.dam.alquilame.exception.dwelling;

public class DwellingNotFoundException extends RuntimeException{

    public DwellingNotFoundException(Long id) {
        super(String.format("The dwelling with id %d could not be found", id));
    }

}
