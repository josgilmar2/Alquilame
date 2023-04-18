package com.salesianostriana.dam.alquilame.validation.validator.general;

import com.salesianostriana.dam.alquilame.validation.annotation.general.FieldsValueMatch;
import org.springframework.beans.PropertyAccessorFactory;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class FieldsValueMatchValidator implements ConstraintValidator<FieldsValueMatch, Object> {

    private String field;
    private String verifyField;

    @Override
    public void initialize(FieldsValueMatch constraintAnnotation) {
        field = constraintAnnotation.field();
        verifyField = constraintAnnotation.verifyField();
    }

    @Override
    public boolean isValid(Object o, ConstraintValidatorContext constraintValidatorContext) {
        Object fieldValue = PropertyAccessorFactory
                .forBeanPropertyAccess(o)
                .getPropertyValue(field);

        Object verifyFieldValue = PropertyAccessorFactory
                .forBeanPropertyAccess(o)
                .getPropertyValue(verifyField);

        if(fieldValue != null)
            return fieldValue.equals(verifyFieldValue);
        return verifyFieldValue == null;
    }
}
