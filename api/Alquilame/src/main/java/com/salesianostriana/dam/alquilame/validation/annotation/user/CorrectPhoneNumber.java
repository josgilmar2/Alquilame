package com.salesianostriana.dam.alquilame.validation.annotation.user;

import com.salesianostriana.dam.alquilame.validation.validator.user.CorrectPhoneNumberValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = CorrectPhoneNumberValidator.class)
@Documented
public @interface CorrectPhoneNumber {

    String message() default "The phone number must be 9 number digits";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    int min() default 9;
    int max() default 9;

    boolean hasNumber() default true;

}
