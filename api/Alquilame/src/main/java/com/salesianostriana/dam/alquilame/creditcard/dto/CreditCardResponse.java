package com.salesianostriana.dam.alquilame.creditcard.dto;

import com.salesianostriana.dam.alquilame.creditcard.model.CreditCard;
import com.salesianostriana.dam.alquilame.creditcard.model.CreditCardBrand;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class CreditCardResponse {

    private Long id;
    private String number, holder, expiredDate;
    private boolean active;
    private CreditCardBrand type;

    public static CreditCardResponse of(CreditCard creditCard) {
        if (creditCard.getType().equals(CreditCardBrand.AMERICAN_EXPRESS) || creditCard.getNumber().length() == 15) {
            return CreditCardResponse.builder()
                    .id(creditCard.getId())
                    .number("**** ****** " + creditCard.getNumber().substring(10, 15))
                    .holder(creditCard.getHolder())
                    .expiredDate(creditCard.getExpiredDate())
                    .active(creditCard.isActive())
                    .type(creditCard.getType())
                    .build();
        } else {
            return CreditCardResponse.builder()
                    .id(creditCard.getId())
                    .number("**** **** **** " + creditCard.getNumber().substring(12, 16))
                    .holder(creditCard.getHolder())
                    .expiredDate(creditCard.getExpiredDate())
                    .active(creditCard.isActive())
                    .type(creditCard.getType())
                    .build();
        }
    }

}
