package es.uma.taw.proyectotaw.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.util.Objects;

@Getter
@Setter
@Embeddable
public class PeliculaId implements java.io.Serializable {
    private static final long serialVersionUID = 9053182396825764288L;
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Usuario_ID", nullable = false)
    private Integer usuarioId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        PeliculaId entity = (PeliculaId) o;
        return Objects.equals(this.id, entity.id) &&
                Objects.equals(this.usuarioId, entity.usuarioId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, usuarioId);
    }

}