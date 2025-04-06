package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "casting")
public class Casting {
    @EmbeddedId
    private CastingId id;

    @MapsId("peliculaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "Pelicula_ID", nullable = false, referencedColumnName = "ID")
    private es.uma.taw.proyectotaw.entity.Pelicula pelicula;

    @MapsId("actorId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "Actor_ID", nullable = false)
    private es.uma.taw.proyectotaw.entity.Actor actor;

    @Column(name = "Personaje", length = 45)
    private String personaje;

}