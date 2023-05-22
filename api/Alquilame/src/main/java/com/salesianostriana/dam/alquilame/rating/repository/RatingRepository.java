package com.salesianostriana.dam.alquilame.rating.repository;

import com.salesianostriana.dam.alquilame.rating.model.Rating;
import com.salesianostriana.dam.alquilame.rating.model.RatingPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.UUID;

public interface RatingRepository extends JpaRepository<Rating, RatingPK> {

    @Query("""
            SELECT CASE WHEN COUNT(r) > 0 THEN true ELSE false END
            FROM Rating r
            WHERE r.user.id = ?1
            AND r.dwelling.id = ?2
            """)
    boolean existsRating(UUID userId, Long dwellingId);

    @Query("SELECT AVG(r.score) FROM Rating r")
    Double findAverageScore();



}
