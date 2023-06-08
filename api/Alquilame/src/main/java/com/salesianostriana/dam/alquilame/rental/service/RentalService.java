package com.salesianostriana.dam.alquilame.rental.service;

import com.salesianostriana.dam.alquilame.creditcard.model.CreditCard;
import com.salesianostriana.dam.alquilame.creditcard.repository.CreditCardRepository;
import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.dwelling.repo.DwellingRepository;
import com.salesianostriana.dam.alquilame.exception.creditcard.CreditCardNotFoundException;
import com.salesianostriana.dam.alquilame.exception.dwelling.DwellingNotFoundException;
import com.salesianostriana.dam.alquilame.exception.rental.PaymentException;
import com.salesianostriana.dam.alquilame.exception.rental.RentalNotFoundException;
import com.salesianostriana.dam.alquilame.exception.rental.RentalOwnDwellingException;
import com.salesianostriana.dam.alquilame.exception.user.UserNotFoundException;
import com.salesianostriana.dam.alquilame.rental.dto.RentalRequest;
import com.salesianostriana.dam.alquilame.rental.model.Rental;
import com.salesianostriana.dam.alquilame.rental.repository.RentalRepository;
import com.salesianostriana.dam.alquilame.user.model.User;
import com.salesianostriana.dam.alquilame.user.service.UserService;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentConfirmParams;
import com.stripe.param.PaymentIntentCreateParams;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.temporal.ChronoUnit;

@Service
@RequiredArgsConstructor
public class RentalService {

    @Value("${stripe.key.secret}")
    private String secretKey;

    private final RentalRepository rentalRepository;
    private final DwellingRepository dwellingRepository;
    private final UserService userService;
    private final CreditCardRepository creditCardRepository;

    public Rental createPaymentIntent(Long dwellingId, User user, RentalRequest dto) {
        try {

            Dwelling dwelling = dwellingRepository.findById(dwellingId)
                    .orElseThrow(() -> new DwellingNotFoundException(dwellingId));

            User user1 = userService.findUserWithDwellings(user.getId())
                    .orElseThrow(() -> new UserNotFoundException(user.getId()));

            CreditCard creditCard = creditCardRepository.findFirstActiveCreditCardByUser(user1)
                    .orElseThrow(CreditCardNotFoundException::new);

            if(user1.getDwellings().contains(dwelling))
                throw new RentalOwnDwellingException();

            if(rentalRepository.existsByDwellingAndEndDateGreaterThanEqualAndStartDateLessThanEqual(dwelling, dto.getStartDate(), dto.getEndDate()))
                throw new PaymentException("A rental already exists during this time period");

            if(user1.getCreditCards().isEmpty())
                throw new PaymentException("You don't have any credit card to pay");

            long days = ChronoUnit.DAYS.between(dto.getStartDate(), dto.getEndDate());
            double totalPrice = dwelling.getPrice() * days;

            Stripe.apiKey = secretKey;

            PaymentIntentCreateParams.Builder paramsBuilder = new PaymentIntentCreateParams.Builder()
                    .setCurrency("eur")
                    .setAmount((long) totalPrice * 100)
                    .setDescription(String.format("Se ha alquilado %s durante %d días", dwelling.getName(), days))
                    .setReceiptEmail(user1.getEmail())
                    .setCustomer(user1.getStripeCustomerId())
                    .setPaymentMethod(creditCard.getStripePaymentMethodId());

            PaymentIntent paymentIntent = PaymentIntent.create(paramsBuilder.build());

            Rental rental = Rental.builder()
                    .startDate(dto.getStartDate())
                    .endDate(dto.getEndDate())
                    .totalPrice(totalPrice)
                    .stripePaymentIntentId(paymentIntent.getId())
                    .paid(false)
                    .build();

            rental.addDwelling(dwelling);
            rental.addUser(user1);

            return rentalRepository.save(rental);

        } catch (StripeException ex) {
            throw new PaymentException("El pago se ha realizado incorrectamente");
        }
    }

    public void confirmPaymentIntent(String paymentIntentId, User user) {
        try {
            Stripe.apiKey = secretKey;

            User user1 = userService.findUserWithDwellings(user.getId())
                    .orElseThrow(() -> new UserNotFoundException(user.getId()));

            CreditCard creditCard = creditCardRepository.findFirstActiveCreditCardByUser(user1)
                    .orElseThrow(CreditCardNotFoundException::new);

            Rental rental = rentalRepository.findByStripePaymentIntentId(paymentIntentId)
                    .orElseThrow(() -> new RentalNotFoundException(paymentIntentId));

            PaymentIntent paymentIntent = PaymentIntent.retrieve(paymentIntentId);
            PaymentIntentConfirmParams.Builder paramsBuilder = new PaymentIntentConfirmParams.Builder()
                    .setPaymentMethod(creditCard.getStripePaymentMethodId());

            PaymentIntentConfirmParams params = paramsBuilder.build();

            rental.setPaid(true);

            rentalRepository.save(rental);

            paymentIntent.confirm(params);

        } catch (StripeException ex) {
            throw new PaymentException("No se pudo confirmar el pago correctamente");
        }
    }

    public void cancelPaymentIntent(String paymentIntentId) {
        try {
            Stripe.apiKey = secretKey;

            PaymentIntent.retrieve(paymentIntentId).cancel();

        } catch (StripeException ex) {
            throw new PaymentException("No se pudo cancelar el pago correctamente");
        }
    }

}
