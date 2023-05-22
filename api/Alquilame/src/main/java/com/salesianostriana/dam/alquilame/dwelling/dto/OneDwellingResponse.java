package com.salesianostriana.dam.alquilame.dwelling.dto;

import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.dwelling.model.Type;
import com.salesianostriana.dam.alquilame.user.dto.UserResponse;
import com.salesianostriana.dam.alquilame.user.model.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.Objects;

@Data
@NoArgsConstructor @AllArgsConstructor
@SuperBuilder
public class OneDwellingResponse extends AllDwellingResponse{

    private String address, description;
    private Type type;
    private double m2;
    private int numBedrooms, numBathrooms;
    private boolean hasElevator, hasPool, hasTerrace, hasGarage, like;
    private UserResponse owner;

    public static OneDwellingResponse of (Dwelling dwelling, User user) {
        return OneDwellingResponse.builder()
                .id(dwelling.getId())
                .name(dwelling.getName())
                .province(dwelling.getProvince().getName())
                .image(dwelling.getImage())
                .price(dwelling.getPrice())
                .averageScore(dwelling.getAverageScore())
                .address(dwelling.getAddress())
                .description(dwelling.getDescription())
                .type(dwelling.getType())
                .m2(dwelling.getM2())
                .numBedrooms(dwelling.getNumBedrooms())
                .numBathrooms(dwelling.getNumBathrooms())
                .hasElevator(dwelling.isHasElevator())
                .hasPool(dwelling.isHasPool())
                .hasTerrace(dwelling.isHasTerrace())
                .hasGarage(dwelling.isHasGarage())
                .like(user.getFavourites()
                        .stream()
                        .filter(d -> Objects.equals(d.getId(), dwelling.getId())).toList().size() > 0)
                .owner(UserResponse.fromUser(dwelling.getUser()))
                .build();
    }

}
