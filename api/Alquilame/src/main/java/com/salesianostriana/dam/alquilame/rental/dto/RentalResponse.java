package com.salesianostriana.dam.alquilame.rental.dto;

import com.salesianostriana.dam.alquilame.rental.model.Rental;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class RentalResponse {

    private Long id;
    private double totalPrice;
    private String userEmail, dwelling, stripePaymentIntentId;
    private LocalDate startDate, endDate;

    public static RentalResponse of(Rental rental) {
        return RentalResponse.builder()
                .id(rental.getId())
                .totalPrice(rental.getTotalPrice())
                .userEmail(rental.getUser().getEmail())
                .dwelling(rental.getDwelling().getName())
                .stripePaymentIntentId(rental.getStipePaymentIntentId())
                .startDate(rental.getStartDate())
                .endDate(rental.getEndDate())
                .build();
    }

}
