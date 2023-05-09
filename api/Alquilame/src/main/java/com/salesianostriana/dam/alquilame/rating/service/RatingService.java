package com.salesianostriana.dam.alquilame.rating.service;

import com.salesianostriana.dam.alquilame.exception.rating.RatingNotFoundException;
import com.salesianostriana.dam.alquilame.rating.model.Rating;
import com.salesianostriana.dam.alquilame.rating.model.RatingPK;
import com.salesianostriana.dam.alquilame.rating.repository.RatingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RatingService {

    private final RatingRepository ratingRepository;

    public Rating save(Rating rating) {
        return ratingRepository.save(rating);
    }

    public Rating findOneRating(RatingPK id) {
        return ratingRepository.findById(id)
                .orElseThrow(() -> new RatingNotFoundException(id));
    }

    public boolean existsRating(UUID userId, Long dwellingId) {
        return ratingRepository.existsRating(userId, dwellingId);
    }

    public Double findAverageScore() {
        return ratingRepository.findAverageScore();
    }

}
