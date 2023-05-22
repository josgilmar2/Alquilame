package com.salesianostriana.dam.alquilame.exception.user;

public class AdminsNotFoundException extends RuntimeException{

    public AdminsNotFoundException() {
        super("No admins were found");
    }

}
