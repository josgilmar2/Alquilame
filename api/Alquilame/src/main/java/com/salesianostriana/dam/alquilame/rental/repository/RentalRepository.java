package com.salesianostriana.dam.alquilame.rental.repository;

import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.ranking.dto.UsersWithMoreRentalsResponse;
import com.salesianostriana.dam.alquilame.rental.model.Rental;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface RentalRepository extends JpaRepository<Rental, Long> {

    boolean existsByDwellingAndEndDateGreaterThanEqualAndStartDateLessThanEqual
            (Dwelling dwelling, LocalDate startDate, LocalDate endDate);

    Optional<Rental> findByStripePaymentIntentId(String stripePaymentIntentId);

    @Query("SELECT NEW com.salesianostriana.dam.alquilame.ranking.dto.UsersWithMoreRentalsResponse(" +
            "r.user.username, " +
            "r.user.avatar, " +
            "COUNT(r) as rentalNumbers, " +
            "SUM(r.totalPrice) as spentMoney) " +
            "FROM Rental r " +
            "WHERE r.paid = true " +
            "GROUP BY r.user.username, r.user.avatar " +
            "ORDER BY rentalNumbers DESC")
    List<UsersWithMoreRentalsResponse> getUsersWithMoreRentals();



}
