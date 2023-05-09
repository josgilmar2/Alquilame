package com.salesianostriana.dam.alquilame.rating.model;

import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import com.salesianostriana.dam.alquilame.user.model.User;
import lombok.*;

import javax.persistence.*;
import java.util.Objects;

@Entity
@NoArgsConstructor @AllArgsConstructor
@Getter @Setter
@Builder
public class Rating {

    @EmbeddedId
    @Builder.Default
    private RatingPK id = new RatingPK();

    @ManyToOne
    @MapsId("user_id")
    @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_RATING_USER"))
    private User user;

    @ManyToOne
    @MapsId("dwelling_id")
    @JoinColumn(name = "dwelling_id", foreignKey = @ForeignKey(name = "FK_RATING_DWELLING"))
    private Dwelling dwelling;

    private double score;
    private String comment;

    //////////////////////////////////////
    /* HELPERS de la asociación con User*/
    //////////////////////////////////////

    public void addUser(User u) {
        this.user = u;
        u.getRatings().add(this);
    }

    public void removeUser(User u) {
        this.user = null;
        u.getRatings().remove(this);
    }

    //////////////////////////////////////////
    /* HELPERS de la asociación con Dwelling*/
    //////////////////////////////////////////

    public void addDwelling(Dwelling d) {
        this.dwelling = d;
        d.getRatings().add(this);
    }

    public void removeDwelling(Dwelling d) {
        this.dwelling = null;
        d.getRatings().remove(this);
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Rating that = (Rating) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }*/

}
