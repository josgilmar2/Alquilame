package com.salesianostriana.dam.alquilame.creditcard.controller;

import com.salesianostriana.dam.alquilame.creditcard.dto.CreditCardRequest;
import com.salesianostriana.dam.alquilame.creditcard.dto.CreditCardResponse;
import com.salesianostriana.dam.alquilame.creditcard.model.CreditCard;
import com.salesianostriana.dam.alquilame.creditcard.service.CreditCardService;
import com.salesianostriana.dam.alquilame.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/creditcard")
@RequiredArgsConstructor
public class CreditCardController {

    private final CreditCardService creditCardService;

    @PostMapping("/")
    public ResponseEntity<CreditCardResponse> create(@Valid @RequestBody CreditCardRequest dto,
                                                     @AuthenticationPrincipal User user) {
        CreditCard result = creditCardService.createCreditCard(dto, user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(CreditCardResponse.of(result));
    }

    @PutMapping("/activate/{id}")
    public CreditCardResponse activateCreditCard(@PathVariable Long id, @AuthenticationPrincipal User user) {
        CreditCard toActivate = creditCardService.activateCreditCard(id, user);

        return CreditCardResponse.of(toActivate);
    }

}
