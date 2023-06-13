package com.salesianostriana.dam.alquilame.exception.ranking;

public class RankingNotFoundException extends RuntimeException{

    public RankingNotFoundException() {
        super("The ranking is empty");
    }

}
