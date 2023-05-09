package com.salesianostriana.dam.alquilame.rating.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class RatingRequest {

    @Positive(message = "")
    @NotNull(message = "")
    private double score;

    private String comment;

}
