package com.salesianostriana.dam.alquilame.dwelling.repo;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.ranking.dto.MostRentedDwellings;
import com.salesianostriana.dam.alquilame.user.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface DwellingRepository extends JpaRepository<Dwelling, Long>, JpaSpecificationExecutor<Dwelling> {

    @EntityGraph(value = "province-with-dwelling")
    List<Dwelling> findAll();

    @Query("""
            SELECT NEW com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse(d.id, d.name, d.province.name, d.image, d.description, d.price, d.averageScore)
            FROM Dwelling d
            WHERE d.user.username = ?1
            """)
    Page<AllDwellingResponse> findAllUserDwellings(String username, Pageable pageable);

    Page<AllDwellingResponse> findByProvinceId(Long idProvince, Pageable pageable);

    @EntityGraph(value = "dwelling-with-ratings", type = EntityGraph.EntityGraphType.LOAD)
    Optional<Dwelling> findFirstById(Long id);

    @Query("""
            SELECT d FROM Dwelling d
            LEFT JOIN FETCH d.ratings r
            WHERE r.user.id = ?1
            """)
    List<Dwelling> dwellingWithRatings(UUID id);

    @Modifying
    @Query("DELETE FROM Rating r WHERE r.dwelling.id = ?1")
    void deleteRatings(Long id);

    @Query("SELECT NEW com.salesianostriana.dam.alquilame.ranking.dto.MostRentedDwellings(" +
            "d.id, d.name, d.province.name, d.image, d.price, d.averageScore) " +
            "FROM Dwelling d " +
            "WHERE EXISTS (SELECT r FROM Rental r WHERE r.dwelling = d AND r.paid = true) " +
            "GROUP BY d.name, d.province.name, d.image, d.price, d.averageScore " +
            "ORDER BY COUNT(*) DESC")
    List<MostRentedDwellings> getMostRentedDwellings();

}
