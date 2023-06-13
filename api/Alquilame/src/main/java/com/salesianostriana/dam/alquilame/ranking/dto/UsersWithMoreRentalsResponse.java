package com.salesianostriana.dam.alquilame.ranking.dto;

import com.salesianostriana.dam.alquilame.rental.model.Rental;
import com.salesianostriana.dam.alquilame.user.model.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class UsersWithMoreRentalsResponse {

    private int position;
    private String username;
    private String avatar;
    private long rentalNumbers;
    private double spentMoney;

    public UsersWithMoreRentalsResponse(String username, String avatar, long rentalNumbers, double spentMoney) {
        this.username = username;
        this.avatar = avatar;
        this.rentalNumbers = rentalNumbers;
        this.spentMoney = spentMoney;
    }
}
