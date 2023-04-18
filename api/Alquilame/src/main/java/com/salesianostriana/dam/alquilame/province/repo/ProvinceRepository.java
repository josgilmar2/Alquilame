package com.salesianostriana.dam.alquilame.province.repo;

import com.salesianostriana.dam.alquilame.province.model.Province;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProvinceRepository extends JpaRepository<Province, Long> {

    Optional<Province> findByName(String name);

}
