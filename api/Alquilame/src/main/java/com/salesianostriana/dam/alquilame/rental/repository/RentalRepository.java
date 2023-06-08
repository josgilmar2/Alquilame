package com.salesianostriana.dam.alquilame.rental.repository;

import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.rental.model.Rental;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Optional;

public interface RentalRepository extends JpaRepository<Rental, Long> {

    boolean existsByDwellingAndEndDateGreaterThanEqualAndStartDateLessThanEqual
            (Dwelling dwelling, LocalDate startDate, LocalDate endDate);

    Optional<Rental> findByStripePaymentIntentId(String stripePaymentIntentId);


}
