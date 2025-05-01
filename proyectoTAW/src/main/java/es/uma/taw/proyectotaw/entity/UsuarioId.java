package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class UsuarioId implements Serializable {
    private static final long serialVersionUID = -5037864234668770287L;
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Tipo_Usuario_ID", nullable = false)
    private Integer tipoUsuarioId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        UsuarioId entity = (UsuarioId) o;
        return Objects.equals(this.id, entity.id) &&
                Objects.equals(this.tipoUsuarioId, entity.tipoUsuarioId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, tipoUsuarioId);
    }

}