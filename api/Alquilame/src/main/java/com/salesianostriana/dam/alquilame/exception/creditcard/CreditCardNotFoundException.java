package com.salesianostriana.dam.alquilame.exception.creditcard;

public class CreditCardNotFoundException extends RuntimeException{

    public CreditCardNotFoundException() {
        super("The credit card cannot be found");
    }

}
