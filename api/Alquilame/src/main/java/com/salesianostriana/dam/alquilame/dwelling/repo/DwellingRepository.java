package com.salesianostriana.dam.alquilame.dwelling.repo;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.user.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DwellingRepository extends JpaRepository<Dwelling, Long>, JpaSpecificationExecutor<Dwelling> {

    @EntityGraph(value = "province-with-dwelling")
    List<Dwelling> findAll();

    @Query("""
            SELECT NEW com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse(d.id, d.name, d.province.name, d.image, d.price)
            FROM Dwelling d
            WHERE d.user.username = ?1
            """)
    Page<AllDwellingResponse> findAllUserDwellings(String username, Pageable pageable);


    Page<AllDwellingResponse> findByProvinceId(Long idProvince, Pageable pageable);
}
