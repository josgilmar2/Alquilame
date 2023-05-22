package com.salesianostriana.dam.alquilame.user.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.salesianostriana.dam.alquilame.user.model.User;
import com.salesianostriana.dam.alquilame.user.model.UserRole;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.EnumSet;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor @AllArgsConstructor
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class LoginResponse extends UserResponse{

    private String token;
    private String refreshToken;

    public LoginResponse(UserResponse userResponse) {
        id = userResponse.getId();
        username = userResponse.getUsername();
        fullName = userResponse.getFullName();
        avatar = userResponse.getAvatar();
        createdAt = userResponse.getCreatedAt();
        address = userResponse.getAddress();
        email = userResponse.getEmail();
        phoneNumber = userResponse.getPhoneNumber();
        numPublications = userResponse.getNumPublications();
        enabled = userResponse.isEnabled();
    }

    public static LoginResponse of (User user, String token, String refreshToken) {
        LoginResponse result = new LoginResponse(UserResponse.fromUser(user));
        result.setRole(convertRoleToString(user.getRoles()));
        result.setToken(token);
        result.setRefreshToken(refreshToken);
        return result;

    }

    public static String convertRoleToString(EnumSet<UserRole> roles) {
        return roles.stream()
                .map(UserRole::name)
                .collect(Collectors.joining(","));
    }

}
