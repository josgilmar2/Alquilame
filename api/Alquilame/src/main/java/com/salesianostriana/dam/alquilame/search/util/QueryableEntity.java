package com.salesianostriana.dam.alquilame.search.util;

import java.lang.reflect.Field;
import java.util.Arrays;

public interface QueryableEntity {

    static boolean checkQueryParam(Class clazz, String fieldname/*, String hiddenFields*/) {
        return Arrays.stream(clazz.getDeclaredFields())
                .map(Field::getName)
                .filter(s -> !s.equalsIgnoreCase("id")) //IGNORAMOS EL ID EN LOS QUERY PARAMS
                .anyMatch(s -> s.equalsIgnoreCase(fieldname));
    }

}
