package com.salesianostriana.dam.alquilame.dwelling.model;

import com.salesianostriana.dam.alquilame.province.model.Province;
import com.salesianostriana.dam.alquilame.user.model.User;
import lombok.*;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;

@Entity
@NoArgsConstructor @AllArgsConstructor
@Getter @Setter
@Builder
public class Dwelling {

    @Id @GeneratedValue
    private Long id;

    private String name, address;

    @Length(max = 6000)
    private String description;

    /*@ElementCollection(fetch = FetchType.EAGER)
    private List<String> images = new ArrayList<>();*/

    private String image;

    @Enumerated(EnumType.STRING)
    private Type type;

    private double price, m2;

    private int numBedrooms, numBathrooms;

    private boolean hasElevator, hasPool, hasTerrace, hasGarage;

    @ManyToOne
    @JoinColumn(name = "province_id", foreignKey = @ForeignKey(name = "FK_DWELLING_PROVINCE"))
    private Province province;

    @ManyToOne
    @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_DWELLING_USER"))
    private User user;

    //////////////////////////////////////////
    /* HELPERS de la asociación con Province*/
    //////////////////////////////////////////

    public void addCity(Province p) {
        this.province = p;
        p.getDwellings().add(this);
    }

    public void deleteCity(Province p) {
        this.province = null;
        p.getDwellings().remove(this);
    }

    //////////////////////////////////////
    /* HELPERS de la asociación con User*/
    //////////////////////////////////////

    public void addUser(User u) {
        this.user = u;
        u.getDwellings().add(this);
    }

    public void removeUser(User u) {
        this.user = null;
        u.getDwellings().remove(this);
    }

}
