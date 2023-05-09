package com.salesianostriana.dam.alquilame.rating.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.UUID;

@Embeddable
@NoArgsConstructor @AllArgsConstructor
@Data
@Builder
public class RatingPK implements Serializable {

    private UUID user_id;
    private Long dwelling_id;

}
