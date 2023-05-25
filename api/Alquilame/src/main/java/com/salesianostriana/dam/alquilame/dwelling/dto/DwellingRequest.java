package com.salesianostriana.dam.alquilame.dwelling.dto;

import com.salesianostriana.dam.alquilame.dwelling.model.Type;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class DwellingRequest {

    @NotEmpty(message = "{dwellingRequest.name.notempty}")
    private String name;

    @NotEmpty(message = "{dwellingRequest.address.notempty}")
    private String address;

    private String description;

    private String image;

    private Type type;

    @Min(value = 100, message = "{dwellingRequest.price.min}")
    private double price;

    @Min(value = 30, message = "{dwellingRequest.m2.min}")
    private double m2;

    @Min(value = 1, message = "{dwellingRequest.numBedrooms.min}")
    private int numBedrooms;

    @Min(value = 1, message = "{dwellingRequest.numBathrooms.min}")
    private int numBathrooms;

    private boolean hasElevator, hasPool, hasTerrace, hasGarage;

    @NotEmpty(message = "{dwellingRequest.provinceName.notnull}")
    private String provinceName;

}
