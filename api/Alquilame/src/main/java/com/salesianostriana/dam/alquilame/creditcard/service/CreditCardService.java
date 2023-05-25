package com.salesianostriana.dam.alquilame.creditcard.service;

import com.salesianostriana.dam.alquilame.creditcard.dto.CreditCardRequest;
import com.salesianostriana.dam.alquilame.creditcard.model.CreditCard;
import com.salesianostriana.dam.alquilame.creditcard.model.CreditCardBrand;
import com.salesianostriana.dam.alquilame.creditcard.repository.CreditCardRepository;
import com.salesianostriana.dam.alquilame.exception.creditcard.CreditCardNotFoundException;
import com.salesianostriana.dam.alquilame.exception.rental.PaymentException;
import com.salesianostriana.dam.alquilame.exception.user.UserNotFoundException;
import com.salesianostriana.dam.alquilame.user.model.User;
import com.salesianostriana.dam.alquilame.user.repo.UserRepository;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentMethod;
import com.stripe.param.PaymentMethodCreateParams;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CreditCardService {

    @Value("${stripe.key.secret}")
    private String secretKey;

    private final CreditCardRepository creditCardRepository;
    private final UserRepository userRepository;

    private PaymentMethod createPaymentMethod(CreditCardRequest dto) {
        try {

            Stripe.apiKey = secretKey;

            PaymentMethodCreateParams.Builder params = new PaymentMethodCreateParams.Builder()
                    .setType(PaymentMethodCreateParams.Type.CARD)
                    .setCard(PaymentMethodCreateParams.CardDetails.builder()
                            .setNumber(dto.getNumber())
                            .setExpMonth(Long.parseLong(dto.getExpiredDate().split("/")[0]))
                            .setExpYear(Long.parseLong(dto.getExpiredDate().split("/")[1]))
                            .setCvc(dto.getCvv())
                            .build());

            return PaymentMethod.create(params.build());

        } catch (StripeException ex) {
            throw new PaymentException("An error occurred while creating the payment method");
        }
    }

    private static CreditCardBrand identify(String number) {
        if (number.startsWith("4")) {
            return CreditCardBrand.VISA;
        } else if (number.startsWith("5")) {
            char digit = number.charAt(1);
            if (digit >= '1'&& digit <= '5') {
                return CreditCardBrand.MASTERCARD;
            }
        } else if (number.startsWith("34") || number.startsWith("37")) {
            return CreditCardBrand.AMERICAN_EXPRESS;
        } else if (number.startsWith("6011") || number.startsWith("65")) {
            return CreditCardBrand.DISCOVER;
        }
        return CreditCardBrand.OTHER;
    }

    public CreditCard createCreditCard(CreditCardRequest dto, User user) {
        String goodCardNumber = dto.getNumber()
                .replaceAll("\\s", "")
                .replaceAll("-", "");

        User user1 = userRepository.findUserWithDwellings(user.getId())
                .orElseThrow(() -> new UserNotFoundException(user.getId()));

        PaymentMethod paymentMethod = createPaymentMethod(dto);

        CreditCard creditCard = CreditCard.builder()
                .number(goodCardNumber)
                .holder(dto.getHolder())
                .expiredDate(dto.getExpiredDate())
                .cvv(dto.getCvv())
                .active(user1.getCreditCards().isEmpty())
                .type(identify(goodCardNumber))
                .stripePaymentMethodId(paymentMethod.getId())
                .build();

        creditCard.addUser(user1);

        return creditCardRepository.save(creditCard);
    }

    @Transactional
    public CreditCard activateCreditCard(Long id, User user) {
        CreditCard toActivate = creditCardRepository.findById(id)
                .orElseThrow(CreditCardNotFoundException::new);

        User user1 = userRepository.findById(user.getId())
                .orElseThrow(() -> new UserNotFoundException(user.getId()));

        if (user1.getCreditCards().stream().filter(creditCard -> Objects.equals(creditCard.getId(), toActivate.getId())).toList().size() > 0){
            user1.getCreditCards().forEach(creditCard -> {
                creditCard.setActive(false);
                creditCardRepository.save(creditCard);
            });
            toActivate.setActive(true);
            creditCardRepository.save(toActivate);
            return toActivate;
        }else {
            throw new EntityNotFoundException();
        }
    }

}
