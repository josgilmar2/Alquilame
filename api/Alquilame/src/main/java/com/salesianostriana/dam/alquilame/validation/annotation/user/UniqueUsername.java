package com.salesianostriana.dam.alquilame.validation.annotation.user;

import com.salesianostriana.dam.alquilame.validation.validator.user.UniqueUsernameValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Constraint(validatedBy = UniqueUsernameValidator.class)
public @interface UniqueUsername{

    String message() default "The username entered already exists";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
