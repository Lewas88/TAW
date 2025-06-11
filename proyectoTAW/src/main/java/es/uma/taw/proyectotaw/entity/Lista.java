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
@Table(name = "lista")
public class Lista {
    @Id
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Nombre", length = 100)
    private String nombre;

    @Lob
    @Column(name = "descripcion")
    private String descripcion;

    @Column(name = "Fecha_Creacion")
    private LocalDate fechaCreacion;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "Usuario_ID", nullable = false)
    private UsuarioEntity usuario;

}