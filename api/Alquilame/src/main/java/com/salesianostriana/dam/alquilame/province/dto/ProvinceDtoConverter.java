package com.salesianostriana.dam.alquilame.province.dto;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import com.salesianostriana.dam.alquilame.province.model.Province;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class ProvinceDtoConverter {

    public ProvinceResponse provinceToProvinceResponse(Province p) {
        List<AllDwellingResponse> aux = new ArrayList<>();

        p.getDwellings().forEach(dwelling -> {
            aux.add(
                    AllDwellingResponse.builder()
                            .id(dwelling.getId())
                            .name(dwelling.getName())
                            .image(dwelling.getImage())
                            .price(dwelling.getPrice())
                            .build()
            );

        });
        return ProvinceResponse.builder()
                .id(p.getId())
                .name(p.getName())
                .dwellings(aux)
                .build();
    }

}
