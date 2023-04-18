package com.salesianostriana.dam.alquilame.validation.validator.user;

import com.salesianostriana.dam.alquilame.validation.annotation.user.CorrectPhoneNumber;
import org.passay.*;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CorrectPhoneNumberValidator implements ConstraintValidator<CorrectPhoneNumber, String> {

    int min, max;
    boolean number;

    @Override
    public void initialize(CorrectPhoneNumber constraintAnnotation) {
        min = constraintAnnotation.min();
        max = constraintAnnotation.max();
        number = constraintAnnotation.hasNumber();;
    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        List<Rule> rules = new ArrayList<>();

        rules.add(new LengthRule(min, max));

        if(number)
            rules.add(new CharacterRule(EnglishCharacterData.Digit, 1));

        PasswordValidator passwordValidator = new PasswordValidator(rules);

        RuleResult result = passwordValidator.validate(new PasswordData(s));

        if(result.isValid())
            return true;

        return false;
    }
}
