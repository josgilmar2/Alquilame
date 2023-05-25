package com.salesianostriana.dam.alquilame.creditcard.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.LuhnCheck;

import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class CreditCardRequest {

    @LuhnCheck
    @NotEmpty(message = "")
    @Length(min = 15, max = 16, message = "")
    private String number;

    @NotEmpty(message = "")
    private String holder;

    @NotEmpty(message = "")
    private String expiredDate;

    @NotEmpty(message = "")
    @Length(min = 3, max = 4, message = "")
    private String cvv;

}
