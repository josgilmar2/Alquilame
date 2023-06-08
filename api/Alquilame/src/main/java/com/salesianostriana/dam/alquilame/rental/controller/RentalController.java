package com.salesianostriana.dam.alquilame.rental.controller;

import com.salesianostriana.dam.alquilame.rental.dto.RentalResponse;
import com.salesianostriana.dam.alquilame.rental.dto.RentalRequest;
import com.salesianostriana.dam.alquilame.rental.model.Rental;
import com.salesianostriana.dam.alquilame.rental.service.RentalService;
import com.salesianostriana.dam.alquilame.user.model.User;
import com.stripe.model.PaymentIntent;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/rental")
@RequiredArgsConstructor
public class RentalController {

    private final RentalService rentalService;

    /*@PostMapping("/{dwellingId}")
    public ResponseEntity<String> createRental(@PathVariable Long dwellingId,
                                                      @AuthenticationPrincipal User user,
                                                      @Valid @RequestBody RentalRequest dto) {
        String result = rentalService.createPaymentIntent(dwellingId, user, dto).toJson();
        return ResponseEntity.ok(result);

    }*/

    @PostMapping("/{dwellingId}")
    public ResponseEntity<RentalResponse> createRental(@PathVariable Long dwellingId,
                                                       @AuthenticationPrincipal User user,
                                                       @Valid @RequestBody RentalRequest dto) {

        Rental result = rentalService.createPaymentIntent(dwellingId, user, dto);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(RentalResponse.of(result));
    }

    @PostMapping("/confirm/{pagoId}")
    public ResponseEntity<?> confirmRental(@PathVariable String pagoId, @AuthenticationPrincipal User user) {
        rentalService.confirmPaymentIntent(pagoId, user);
        return ResponseEntity.status(HttpStatus.OK)
                .build();
    }

    @PostMapping("/cancel/{pagoId}")
    public ResponseEntity<?> cancelRental(@PathVariable String pagoId) {
        rentalService.cancelPaymentIntent(pagoId);
        return ResponseEntity.status(HttpStatus.OK)
                .build();
    }

}
