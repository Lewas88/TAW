package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "genero")
public class Genero {
    @Id
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Nombre", length = 45)
    private String nombre;

}