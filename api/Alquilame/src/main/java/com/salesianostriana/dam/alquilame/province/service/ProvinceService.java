package com.salesianostriana.dam.alquilame.province.service;

import com.salesianostriana.dam.alquilame.exception.EmptyListNotFoundException;
import com.salesianostriana.dam.alquilame.exception.province.ProvinceBadRequestDeleteException;
import com.salesianostriana.dam.alquilame.province.dto.ProvinceDtoConverter;
import com.salesianostriana.dam.alquilame.province.dto.ProvinceRequest;
import com.salesianostriana.dam.alquilame.province.dto.ProvinceResponse;
import com.salesianostriana.dam.alquilame.province.model.Province;
import com.salesianostriana.dam.alquilame.province.repo.ProvinceRepository;
import com.salesianostriana.dam.alquilame.exception.province.ProvinceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProvinceService {

    private final ProvinceRepository provinceRepository;
    private final ProvinceDtoConverter provinceDtoConverter;

    public List<Province> findAll() {
        List<Province> result = provinceRepository.findAll();
        if (result.isEmpty())
            throw new RuntimeException("No provinces found");
        return result;
    }

    public Province findById(Long id) {
        return provinceRepository.findById(id)
                .orElseThrow(() -> new ProvinceNotFoundException(id));
    }

    public Province create(ProvinceRequest dto) {
        Province result = Province.builder()
                .name(dto.getName())
                .build();

        return provinceRepository.save(result);
    }

    public Province edit(Long id, ProvinceRequest dto) {
        return provinceRepository.findById(id)
                .map(province -> {
                    province.setName(dto.getName());
                    return provinceRepository.save(province);
                }).orElseThrow(() -> new ProvinceNotFoundException(id));
    }

    public void delete(Long id) {
        if(!provinceRepository.existsById(id))
            throw new ProvinceBadRequestDeleteException(id);;
        provinceRepository.deleteById(id);
    }

    public Province findByName(String name) {
        return provinceRepository.findByName(name)
                .orElseThrow(() -> new ProvinceNotFoundException(name));
    }

}
