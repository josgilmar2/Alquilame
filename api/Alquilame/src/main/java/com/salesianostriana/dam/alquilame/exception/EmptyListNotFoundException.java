package com.salesianostriana.dam.alquilame.exception;

public class EmptyListNotFoundException extends RuntimeException{

    public EmptyListNotFoundException(Class clazz) {
        super(String.format("Cannot find data of type %s.", clazz.getName().split("\\.")[4]));
    }

}
