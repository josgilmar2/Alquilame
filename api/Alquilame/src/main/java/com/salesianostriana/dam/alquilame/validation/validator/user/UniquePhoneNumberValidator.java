package com.salesianostriana.dam.alquilame.validation.validator.user;

import com.salesianostriana.dam.alquilame.user.service.UserService;
import com.salesianostriana.dam.alquilame.validation.annotation.user.UniquePhoneNumber;
import lombok.RequiredArgsConstructor;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

@RequiredArgsConstructor
public class UniquePhoneNumberValidator implements ConstraintValidator<UniquePhoneNumber, String> {

    private final UserService userService;

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        return !userService.existsByPhoneNumber(s);
    }
}
