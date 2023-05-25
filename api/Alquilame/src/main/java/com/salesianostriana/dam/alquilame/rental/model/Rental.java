package com.salesianostriana.dam.alquilame.rental.model;

import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.user.model.User;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@NoArgsConstructor @AllArgsConstructor
@Getter @Setter
@Builder
public class Rental {

    @Id @GeneratedValue
    private Long id;

    private LocalDate startDate, endDate;

    private double totalPrice;

    private String stipePaymentIntentId;

    @ManyToOne
    @JoinColumn(name = "dwelling_id", foreignKey = @ForeignKey(name = "FK_RENTAL_DWELLING"))
    private Dwelling dwelling;

    @ManyToOne
    @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_RENTAL_USER"))
    private User user;

    //////////////////////////////////////////
    /* HELPERS de la asociación con Dwelling*/
    //////////////////////////////////////////

    public void addDwelling(Dwelling d) {
        this.dwelling = d;
        d.getRentals().add(this);
    }

    public void removeDwelling(Dwelling d) {
        this.dwelling = null;
        d.getRentals().remove(this);
    }

    //////////////////////////////////////
    /* HELPERS de la asociación con User*/
    //////////////////////////////////////

    public void addUser(User u) {
        this.user = u;
        u.getRentals().add(this);
    }

    public void deleteUser(User u) {
        this.user = null;
        u.getRentals().remove(this);
    }

}
