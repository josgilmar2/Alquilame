package com.salesianostriana.dam.alquilame.ranking.controller;

import com.salesianostriana.dam.alquilame.dwelling.service.DwellingService;
import com.salesianostriana.dam.alquilame.ranking.dto.MostRentedDwellings;
import com.salesianostriana.dam.alquilame.ranking.dto.UsersWithMoreRentalsResponse;
import com.salesianostriana.dam.alquilame.rental.service.RentalService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/ranking")
@RequiredArgsConstructor
public class RankingController {

    private final RentalService rentalService;
    private final DwellingService dwellingService;

    @GetMapping("/user/more/rental")
    public List<UsersWithMoreRentalsResponse> getUsersWithMoreRentalsResponse() {
        return rentalService.getUserWithMoreRentalsResponse();
    }

    @GetMapping("/dwelling/more/rental")
    public List<MostRentedDwellings> getMostRentedDwellings() {
        return dwellingService.getMostRentedDwellings();
    }

}
