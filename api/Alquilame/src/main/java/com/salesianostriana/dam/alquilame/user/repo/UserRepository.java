package com.salesianostriana.dam.alquilame.user.repo;

import com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse;
import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.user.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID>, JpaSpecificationExecutor<User> {

    Optional<User> findFirstByUsername(String username);

    @Query("""
            SELECT u FROM User u
            LEFT JOIN FETCH u.dwellings
            WHERE u.id = ?1
            """)
    Optional<User> findUserWithDwellings(UUID id);

    @Query("""
            SELECT u FROM User u
            LEFT JOIN FETCH u.favourites
            WHERE u.id = ?1
            """)
    Optional<User> findUserFavouriteDwellings(UUID id);

    @Query("""
            SELECT CASE WHEN (COUNT(u) > 0) THEN true ELSE false END
            FROM User u
            JOIN u.favourites f
            WHERE u.id = ?1
            AND f.id = ?2
            """)
    boolean existFavourite(UUID id, Long idDwelling);

    @Query("""
            SELECT u FROM User u 
            LEFT JOIN FETCH u.favourites f 
            WHERE f.id = ?1
            """)
    List<User> findFavouriteUserDwellings(Long idDwelling);

    @Query("""
            SELECT NEW com.salesianostriana.dam.alquilame.dwelling.dto.AllDwellingResponse(f.id, f.name, f.province.name, f.image, f.price)
            FROM User u 
            JOIN u.favourites f
            WHERE u.id = ?1
            """)
    Page<AllDwellingResponse> findFavourites(UUID id, Pageable pageable);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    boolean existsByPhoneNumber(String phoneNumber);

}
