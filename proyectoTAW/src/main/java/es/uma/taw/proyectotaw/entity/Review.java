package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "review")
public class Review {
    @EmbeddedId
    private ReviewId id;

    @MapsId("usuarioId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "Usuario_ID", nullable = false)
    private es.uma.taw.proyectotaw.entity.Usuario usuario;

    @MapsId("id")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Pelicula pelicula;

    @Column(name = "Califica")
    private Double califica;

    @Column(name = "Comentario", length = 300)
    private String comentario;

    @Column(name = "Fecha")
    private LocalDate fecha;

}