package com.salesianostriana.dam.alquilame.province.dto;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class ProvinceResponse {

    private Long id;
    private String name;
    private List<AllDwellingResponse> dwellings;

}
