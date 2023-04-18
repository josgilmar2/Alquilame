package com.salesianostriana.dam.alquilame.user.dto;

import com.salesianostriana.dam.alquilame.user.model.UserRole;
import com.salesianostriana.dam.alquilame.validation.annotation.general.FieldsValueMatch;
import com.salesianostriana.dam.alquilame.validation.annotation.user.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor @AllArgsConstructor
@Builder
@FieldsValueMatch.List({
        @FieldsValueMatch(field = "password", verifyField = "verifyPassword",
                message = "{createUserDto.password.nomatch}")
})
public class CreateUserDto {

    @UniqueUsername(message = "{createUserDto.username.unique}")
    @NotEmpty(message = "{createUserDto.username.notempty}")
    private String username;

    @NotEmpty(message = "{createUserDto.fullName.notempty}")
    private String fullName;

    @Email(message = "{createUserDto.email.email}")
    @NotEmpty(message = "{createUserDto.email.notempty}")
    @UniqueEmail(message = "{createUserDto.email.unique}")
    private String email;

    private String address;

    @NotEmpty(message = "{createUserDto.phoneNumber.notempty}")
    @UniquePhoneNumber(message = "{createUserDto.phoneNumber.unique}")
    @CorrectPhoneNumber(message = "{createUserDto.phoneNumber.correct}")
    private String phoneNumber;

    private String avatar;

    @StrongPassword
    @NotEmpty(message = "{createUserDto.password.notempty}")
    private String password;

    @NotEmpty(message = "{createUserDto.verifyPassword.notempty}")
    private String verifyPassword;

}
