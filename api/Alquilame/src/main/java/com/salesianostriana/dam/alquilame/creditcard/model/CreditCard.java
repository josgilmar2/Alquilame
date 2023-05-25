package com.salesianostriana.dam.alquilame.creditcard.model;

import com.salesianostriana.dam.alquilame.user.model.User;
import lombok.*;

import javax.persistence.*;

@Entity
@NoArgsConstructor @AllArgsConstructor
@Getter @Setter
@Builder
public class CreditCard {

    @Id @GeneratedValue
    private Long id;

    private String number, holder, expiredDate, cvv, stripePaymentMethodId;

    private boolean active;

    @Enumerated(EnumType.STRING)
    private CreditCardBrand type;

    @ManyToOne
    @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_CREDIT_CARD_USER"))
    private User user;

    //////////////////////////////////////
    /* HELPERS de la asociación con User*/
    //////////////////////////////////////

    public void addUser(User u) {
        this.user = u;
        u.getCreditCards().add(this);
    }

    public void deleteUser(User u) {
        this.user = null;
        u.getCreditCards().remove(this);
    }

}
