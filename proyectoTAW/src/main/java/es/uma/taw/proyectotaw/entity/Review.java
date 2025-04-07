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
@Table(name = "review")
public class Review {
    @Id
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Califica")
    private Double califica;

    @Column(name = "Comentario", length = 500)
    private String comentario;

    @Column(name = "Fecha")
    private LocalDate fecha;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Usuario_ID", nullable = false)
    private es.uma.taw.proyectotaw.entity.Usuario usuario;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Pelicula_ID", nullable = false)
    private Pelicula pelicula;

}