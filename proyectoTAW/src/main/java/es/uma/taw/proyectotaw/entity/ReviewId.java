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
public class ReviewId implements java.io.Serializable {
    private static final long serialVersionUID = -6502471468384747283L;
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "Usuario_ID", nullable = false)
    private Integer usuarioId;

    @Column(name = "pelicula_ID", nullable = false)
    private Integer peliculaId;

    @Column(name = "Pelicula_Usuario_ID", nullable = false)
    private Integer peliculaUsuarioId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ReviewId entity = (ReviewId) o;
        return Objects.equals(this.peliculaId, entity.peliculaId) &&
                Objects.equals(this.peliculaUsuarioId, entity.peliculaUsuarioId) &&
                Objects.equals(this.id, entity.id) &&
                Objects.equals(this.usuarioId, entity.usuarioId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(peliculaId, peliculaUsuarioId, id, usuarioId);
    }

}