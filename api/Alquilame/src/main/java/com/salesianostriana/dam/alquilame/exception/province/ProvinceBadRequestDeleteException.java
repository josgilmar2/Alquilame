package com.salesianostriana.dam.alquilame.exception.province;

public class ProvinceBadRequestDeleteException extends RuntimeException{

    public ProvinceBadRequestDeleteException(Long id) {
        super("The province with id %d you want to delete doesn't exist");
    }

}
