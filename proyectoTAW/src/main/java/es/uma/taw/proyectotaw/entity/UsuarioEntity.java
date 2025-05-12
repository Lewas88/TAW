package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "usuario")
public class UsuarioEntity {
    @Id
    @Column(name = "ID")
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "Tipo_Usuario_ID", nullable = false)
    private TipoUsuario tipoUsuario;

    @Column(name = "Nombre", length = 100)
    private String nombre;

    @Column(name = "Correo", length = 100)
    private String correo;

    @Column(name = "Contrasena_Hash")
    private String contrasenaHash;

}