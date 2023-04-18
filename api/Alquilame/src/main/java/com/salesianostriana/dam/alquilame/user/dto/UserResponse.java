package com.salesianostriana.dam.alquilame.user.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.alquilame.user.model.User;
import com.salesianostriana.dam.alquilame.user.model.UserRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;
import java.util.EnumSet;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor @AllArgsConstructor
@SuperBuilder
public class UserResponse {

    protected String id, username, avatar, fullName, address, email, role, phoneNumber;

    protected int numPublications;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    protected LocalDateTime createdAt;

    public static UserResponse fromUser(User user) {

        return UserResponse.builder()
                .id(user.getId().toString())
                .username(user.getUsername())
                .avatar(user.getAvatar())
                .fullName(user.getFullName())
                .address(user.getAddress())
                .email(user.getEmail())
                .phoneNumber(user.getPhoneNumber())
                .role(convertRoleToString(user.getRoles()))
                .numPublications(user.getDwellings().size())
                .createdAt(user.getCreatedAt())
                .build();
    }

    public static String convertRoleToString(EnumSet<UserRole> roles) {
        return roles.stream()
                .map(UserRole::name)
                .collect(Collectors.joining(","));
    }

}
