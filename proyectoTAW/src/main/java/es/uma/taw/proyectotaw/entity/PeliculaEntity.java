package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "pelicula")
public class PeliculaEntity {
    @Id
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Titulo", length = 100)
    private String titulo;

    @Column(name = "Fecha_Estreno")
    private LocalDate fechaEstreno;

    @Lob
    @Column(name = "Sinopsis")
    private String sinopsis;

    @Column(name = "Presupuesto")
    private Integer presupuesto;

    @Column(name = "Ingresos")
    private Long ingresos;

    @Column(name = "Rating")
    private Double rating;

    @Column(name = "Duracion")
    private Integer duracion;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Usuario_ID", nullable = false, referencedColumnName = "ID")
    private UsuarioEntity usuario;

}