package com.salesianostriana.dam.alquilame.user.dto;

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
public class LoginResponse extends UserResponse{

    private String token;

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
    }

    public static LoginResponse of (User user, String token) {
        LoginResponse result = new LoginResponse(UserResponse.fromUser(user));
        result.setRole(convertRoleToString(user.getRoles()));
        result.setToken(token);
        return result;

    }

    public static String convertRoleToString(EnumSet<UserRole> roles) {
        return roles.stream()
                .map(UserRole::name)
                .collect(Collectors.joining(","));
    }

}
