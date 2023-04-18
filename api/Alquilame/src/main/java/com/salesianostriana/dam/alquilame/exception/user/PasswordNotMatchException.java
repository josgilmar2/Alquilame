package com.salesianostriana.dam.alquilame.exception.user;

public class PasswordNotMatchException extends RuntimeException{

    public PasswordNotMatchException() {
        super("Your old password is bad written. Please try again");
    }

}
