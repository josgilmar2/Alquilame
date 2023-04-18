package com.salesianostriana.dam.alquilame.validation.annotation.user;

import com.salesianostriana.dam.alquilame.validation.validator.user.StrongPasswordValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = StrongPasswordValidator.class)
@Documented
public @interface StrongPassword {

    String message() default "La contraseña no reúne los requisitos establecidos";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    int min() default 8;
    int max() default Integer.MAX_VALUE;

    boolean hasUpperCase() default true;
    boolean hasLowerCase() default true;
    boolean hasAlpha() default true;
    boolean hasNumber() default true;
    boolean hasSpecial() default true;

}
