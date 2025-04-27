package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "trabajador_pelicula")
public class TrabajadorPelicula {
    @EmbeddedId
    private TrabajadorPeliculaId id;

    @MapsId("trabajadorId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Trabajador_ID", nullable = false)
    private Trabajador trabajador;

    @MapsId("peliculaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Pelicula_ID", nullable = false)
    private PeliculaEntity pelicula;

    @Column(name = "Tipo_Trabajo", length = 50)
    private String tipoTrabajo;

}