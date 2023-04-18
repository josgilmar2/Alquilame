package com.salesianostriana.dam.alquilame.validation.annotation.user;

import com.salesianostriana.dam.alquilame.validation.validator.user.OldPasswordMatchValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = OldPasswordMatchValidator.class)
@Documented
public @interface OldPasswordMatch {

    String message() default "The password entered must be different to the old one.";

    Class <?> [] groups() default {};

    Class <? extends Payload> [] payload() default {};

    String oldPasswordField();
    String newPasswordField();

}
