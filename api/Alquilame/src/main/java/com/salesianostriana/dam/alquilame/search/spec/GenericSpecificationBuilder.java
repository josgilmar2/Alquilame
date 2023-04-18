package com.salesianostriana.dam.alquilame.search.spec;

import com.salesianostriana.dam.alquilame.search.util.QueryableEntity;
import com.salesianostriana.dam.alquilame.search.util.SearchCriteria;
import lombok.AllArgsConstructor;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.stream.Collectors;

@AllArgsConstructor
public class GenericSpecificationBuilder<T> {

    private List<SearchCriteria> params;
    private Class type;

    public Specification<T> build() {
        List<SearchCriteria> checkedParams = params.stream()
                .filter(searchCriteria -> QueryableEntity.checkQueryParam(type, searchCriteria.getKey()))
                .collect(Collectors.toList());

        if(checkedParams.isEmpty()) {
            return null;
        }

        Specification<T> result = new GenericSpecification<T>(params.get(0));

        for(int i = 0; i < params.size(); i++) {
            result = result.and(new GenericSpecification<T>(params.get(i)));
        }
        return result;
    }


}
