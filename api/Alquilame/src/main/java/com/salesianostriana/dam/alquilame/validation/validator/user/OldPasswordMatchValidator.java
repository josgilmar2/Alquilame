package com.salesianostriana.dam.alquilame.validation.validator.user;

import com.salesianostriana.dam.alquilame.validation.annotation.user.OldPasswordMatch;
import org.springframework.beans.PropertyAccessorFactory;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class OldPasswordMatchValidator implements ConstraintValidator<OldPasswordMatch, Object> {

    private String oldPasswordField;
    private String newPasswordField;

    @Override
    public void initialize(OldPasswordMatch constraintAnnotation) {
        oldPasswordField = constraintAnnotation.oldPasswordField();
        newPasswordField  = constraintAnnotation.newPasswordField();
    }

    @Override
    public boolean isValid(Object o, ConstraintValidatorContext constraintValidatorContext) {
        String oldPassword = (String) PropertyAccessorFactory
                .forBeanPropertyAccess(o)
                .getPropertyValue(oldPasswordField);

        String newPassword = (String) PropertyAccessorFactory
                .forBeanPropertyAccess(o)
                .getPropertyValue(newPasswordField);

        return StringUtils.hasText(oldPassword) && !oldPassword.equals(newPassword);
    }

}
