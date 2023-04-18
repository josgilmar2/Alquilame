package com.salesianostriana.dam.alquilame.exception.province;

public class ProvinceNotFoundException extends RuntimeException{

    public ProvinceNotFoundException(Long id) {
        super(String.format("No province with id %d was found.", id));
    }

    public ProvinceNotFoundException(String name) {
        super(String.format("No province find with name: %s was found", name));
    }

}
