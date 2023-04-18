package com.salesianostriana.dam.alquilame.validation.annotation.user;

import com.salesianostriana.dam.alquilame.validation.validator.user.UniquePhoneNumberValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniquePhoneNumberValidator.class)
@Documented
public @interface UniquePhoneNumber {

    String message() default "The phone number entered already exists";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
