package com.salesianostriana.dam.alquilame.creditcard.repository;

import com.salesianostriana.dam.alquilame.creditcard.model.CreditCard;
import com.salesianostriana.dam.alquilame.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface CreditCardRepository extends JpaRepository<CreditCard, Long> {

    @Query("SELECT c FROM CreditCard c WHERE c.user = :user AND c.active = true")
    Optional<CreditCard> findFirstActiveCreditCardByUser(User user);

    @Query("SELECT c FROM CreditCard c WHERE c.user = :user")
    List<CreditCard> findAllUserCreditCards(User user);

}
