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
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Titulo", length = 100)
    private String titulo;

    @Column(name = "Fecha_Estreno")
    private LocalDate fechaEstreno;

    @Lob
    @Column(name = "Sinopsis" , columnDefinition = "TEXT")
    private String sinopsis;

    @Column(name = "Presupuesto")
    private Integer presupuesto;

    @Column(name = "Ingresos")
    private Long ingresos;

    @Column(name = "Rating")
    private Double rating;

    @Column(name = "Duracion")
    private Integer duracion;

}