package com.salesianostriana.dam.alquilame.user.dto;

import com.salesianostriana.dam.alquilame.validation.annotation.user.CorrectPhoneNumber;
import com.salesianostriana.dam.alquilame.validation.annotation.user.UniquePhoneNumber;
import com.salesianostriana.dam.alquilame.validation.annotation.user.UniqueUsername;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
public class EditUserProfileDto {

    @NotEmpty(message = "{createUserDto.fullName.notempty}")
    private String fullName;

    private String address;

    @NotEmpty(message = "{createUserDto.phoneNumber.notEmpty}")
    @UniquePhoneNumber(message = "{createUserDto.phoneNumber.unique}")
    @CorrectPhoneNumber(message = "{createUserDto.phoneNumber.correct}")
    private String phoneNumber;
}
