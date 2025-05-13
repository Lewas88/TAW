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
@Table(name = "lista_pelicula")
public class ListaPelicula {
    @EmbeddedId
    private ListaPeliculaId id;

    @MapsId("listaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Lista_ID", nullable = false)
    private Lista lista;

    @MapsId("peliculaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Pelicula_ID", nullable = false)
    private Pelicula pelicula;

    @Column(name = "Fecha_Agregada")
    private LocalDate fechaAgregada;

}