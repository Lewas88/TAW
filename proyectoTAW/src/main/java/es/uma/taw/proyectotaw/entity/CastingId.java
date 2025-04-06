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
public class CastingId implements java.io.Serializable {
    private static final long serialVersionUID = 7063105629510318758L;
    @Column(name = "Pelicula_ID", nullable = false)
    private Integer peliculaId;

    @Column(name = "Actor_ID", nullable = false)
    private Integer actorId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        CastingId entity = (CastingId) o;
        return Objects.equals(this.actorId, entity.actorId) &&
                Objects.equals(this.peliculaId, entity.peliculaId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(actorId, peliculaId);
    }

}