package com.salesianostriana.dam.alquilame.exception.rental;

public class RentalNotFoundException extends RuntimeException{
    public RentalNotFoundException(String stripeId) {
        super(String.format("The rental with stripe id: %s doesn't exist", stripeId));
    }
}
