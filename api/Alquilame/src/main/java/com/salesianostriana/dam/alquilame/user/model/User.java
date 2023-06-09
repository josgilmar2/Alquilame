package com.salesianostriana.dam.alquilame.user.model;

import com.salesianostriana.dam.alquilame.creditcard.model.CreditCard;
import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.rating.model.Rating;
import com.salesianostriana.dam.alquilame.rental.model.Rental;
import com.salesianostriana.dam.alquilame.user.database.EnumSetUserRoleConverter;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NaturalId;
import org.hibernate.annotations.Parameter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Entity
@Table(name = "user_entity")
@NoArgsConstructor @AllArgsConstructor
@Getter @Setter
@Builder
@NamedEntityGraph(name = "user-with-dwelling",
        attributeNodes = {
                @NamedAttributeNode(value = "dwellings")
        })
@NamedEntityGraph(name = "user-with-favourites",
        attributeNodes = {
            @NamedAttributeNode(value = "favourites",
                    subgraph = "favourites-with-ratings")
        }, subgraphs = {
        @NamedSubgraph(name = "favourites-with-ratings",
        attributeNodes = {
                @NamedAttributeNode("ratings")
        })
})
public class User implements UserDetails {

    @Id @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Column(columnDefinition = "uuid")
    private UUID id;

    @NaturalId
    @Column(unique = true, updatable = false)
    private String username;

    private String address, phoneNumber, email, password, avatar, fullName;

    @Convert(converter = EnumSetUserRoleConverter.class)
    private EnumSet<UserRole> roles;

    @Builder.Default
    private LocalDateTime createdAt = LocalDateTime.now();

    @Builder.Default
    private LocalDateTime lastPasswordChangeAt = LocalDateTime.now();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<Dwelling> dwellings = new ArrayList<>();

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    @JoinTable(joinColumns = @JoinColumn(name = "user_id",
                            foreignKey = @ForeignKey(name = "FK_FAVOURITES_USER")),
                inverseJoinColumns = @JoinColumn(name = "dwelling_id",
                            foreignKey = @ForeignKey(name = "FK_FAVOURITES_DWELLING")),
                name = "favourites")
    private List<Dwelling> favourites;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    @Builder.Default
    private List<Rating> ratings= new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    @Builder.Default
    private List<Rental> rentals = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<CreditCard> creditCards = new ArrayList<>();

    private String stripeCustomerId;

    @Builder.Default
    private boolean accountNonExpired = true;

    @Builder.Default
    private boolean accountNonLocked = true;

    @Builder.Default
    private boolean credentialsNonExpired = true;

    @Builder.Default
    private boolean enabled = true;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles.stream()
                .map(role -> "ROLE_" + role)
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return accountNonExpired;
    }

    @Override
    public boolean isAccountNonLocked() {
        return accountNonLocked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return credentialsNonExpired;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }

    @PreRemove
    public void setNullUserInRentals() {
        rentals.forEach(rental -> rental.setUser(null));
    }
}
