package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "casting")
public class Casting {
    @EmbeddedId
    private CastingId id;

    @MapsId("peliculaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Pelicula_ID", nullable = false)
    private es.uma.taw.proyectotaw.entity.Pelicula pelicula;

    @MapsId("actorId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Actor_ID", nullable = false)
    private Actor actor;

    @Column(name = "Personaje", length = 100)
    private String personaje;

}