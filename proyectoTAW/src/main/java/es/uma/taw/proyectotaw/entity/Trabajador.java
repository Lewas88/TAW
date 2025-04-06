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
@Table(name = "trabajador")
public class Trabajador {
    @Id
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Nombre", length = 20)
    private String nombre;

    @Column(name = "Puesto", length = 30)
    private String puesto;

    @Column(name = "Departamento", length = 30)
    private String departamento;

}