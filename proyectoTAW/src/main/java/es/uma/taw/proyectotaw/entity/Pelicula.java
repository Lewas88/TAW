package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "pelicula")
public class Pelicula {
    @EmbeddedId
    private PeliculaId id;

    @MapsId("usuarioId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "Usuario_ID", nullable = false)
    private es.uma.taw.proyectotaw.entity.Usuario usuario;

    @Column(name = "Titulo", length = 45)
    private String titulo;

    @Column(name = "Fecha_Estreno")
    private LocalDate fechaEstreno;

    @Column(name = "Sinopsis", length = 300)
    private String sinopsis;

    @Column(name = "Presupuesto")
    private Integer presupuesto;

    @Column(name = "Ingresos")
    private Integer ingresos;

    @Column(name = "Rating")
    private Double rating;

    @Column(name = "Duracion")
    private Integer duracion;

}