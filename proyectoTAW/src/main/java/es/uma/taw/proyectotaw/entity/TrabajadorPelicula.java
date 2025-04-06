package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "trabajador_pelicula")
public class TrabajadorPelicula {
    @EmbeddedId
    private TrabajadorPeliculaId id;

    @MapsId("trabajadorId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "Trabajador_ID", nullable = false)
    private Trabajador trabajador;

    @MapsId("peliculaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "Pelicula_ID", nullable = false, referencedColumnName = "ID")
    private Pelicula pelicula;

    @Column(name = "Tipo_Trabajo", length = 20)
    private String tipoTrabajo;

}