package com.salesianostriana.dam.alquilame.province.model;

import com.salesianostriana.dam.alquilame.dwelling.model.Dwelling;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor @AllArgsConstructor
@Getter @Setter
@Builder
@NamedEntityGraph(name = "province-with-dwelling",
        attributeNodes = {
                @NamedAttributeNode(value = "dwellings")
        })
public class Province {

    @Id @GeneratedValue
    private Long id;

    private String name;

    @OneToMany(mappedBy = "province", fetch = FetchType.LAZY)
    @Builder.Default
    private List<Dwelling> dwellings = new ArrayList<>();

    @PreRemove
    public void setNullProvinces() {
        dwellings.forEach(dwelling -> dwelling.setProvince(null));
    }

}
