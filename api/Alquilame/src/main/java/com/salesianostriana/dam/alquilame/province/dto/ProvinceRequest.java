package com.salesianostriana.dam.alquilame.province.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class ProvinceRequest {

    @NotEmpty(message = "{provinceRequest.name.notempty}")
    private String name;

}
