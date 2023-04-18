package com.salesianostriana.dam.alquilame.dwelling.dto;

import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor @AllArgsConstructor
@SuperBuilder
public class AllDwellingResponse {

    protected Long id;
    protected String name, province, image;
    protected double price;

    public static AllDwellingResponse of(Dwelling dwelling) {
        return AllDwellingResponse.builder()
                .id(dwelling.getId())
                .name(dwelling.getName())
                .province(dwelling.getProvince().getName())
                .image(dwelling.getImage())
                .price(dwelling.getPrice())
                .build();
    }
}
