package com.salesianostriana.dam.alquilame.ranking.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MostRentedDwellings {

    private Long id;
    private int position;
    private String name, province, image;
    private double price, averageScore;

    public MostRentedDwellings(Long id, String name, String province, String image, double price, double averageScore) {
        this.id = id;
        this.name = name;
        this.province = province;
        this.image = image;
        this.price = price;
        this.averageScore = averageScore;
    }
}
