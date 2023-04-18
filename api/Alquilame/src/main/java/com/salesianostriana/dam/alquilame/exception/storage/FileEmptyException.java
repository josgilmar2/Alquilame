package com.salesianostriana.dam.alquilame.exception.storage;

public class FileEmptyException extends RuntimeException{

    public FileEmptyException() {
        super("The file is empty");
    }

}
