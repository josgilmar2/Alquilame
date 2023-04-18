package com.salesianostriana.dam.alquilame.validation.validator.user;

import com.salesianostriana.dam.alquilame.validation.annotation.user.StrongPassword;
import org.passay.*;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class StrongPasswordValidator implements ConstraintValidator<StrongPassword, String> {

    int min, max;
    boolean upper, lower, alpha, number, special;

    @Override
    public void initialize(StrongPassword constraintAnnotation) {
        min = constraintAnnotation.min();
        max = constraintAnnotation.max();
        upper = constraintAnnotation.hasUpperCase();
        lower = constraintAnnotation.hasLowerCase();
        alpha = constraintAnnotation.hasAlpha();
        number = constraintAnnotation.hasNumber();
        special = constraintAnnotation.hasSpecial();
    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        List<Rule> rules = new ArrayList<>();

        rules.add(new LengthRule(min, max));

        if(alpha) {
            rules.add(new CharacterRule(EnglishCharacterData.Alphabetical, 1));

            if(upper) {
                rules.add(new CharacterRule(EnglishCharacterData.UpperCase, 1));
            }

            if(lower) {
                rules.add(new CharacterRule(EnglishCharacterData.LowerCase, 1));
            }
        }

        if(number)
            rules.add(new CharacterRule(EnglishCharacterData.Digit, 1));

        if(special)
            rules.add(new CharacterRule(EnglishCharacterData.Special, 1));

        PasswordValidator passwordValidator = new PasswordValidator(rules);

        RuleResult result = passwordValidator.validate(new PasswordData(s));

        if(result.isValid())
            return true;

        List<String> messages = passwordValidator.getMessages(result);
        String template = messages.stream()
                .collect(Collectors.joining(", "));
        constraintValidatorContext.buildConstraintViolationWithTemplate(template)
                .addConstraintViolation()
                .disableDefaultConstraintViolation();

        return false;

    }

}
