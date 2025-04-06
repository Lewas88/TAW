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
public class GeneroPeliculaId implements java.io.Serializable {
    private static final long serialVersionUID = 8171010304025660721L;
    @Column(name = "Pelicula_ID", nullable = false)
    private Integer peliculaId;

    @Column(name = "Genero_ID", nullable = false)
    private Integer generoId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        GeneroPeliculaId entity = (GeneroPeliculaId) o;
        return Objects.equals(this.peliculaId, entity.peliculaId) &&
                Objects.equals(this.generoId, entity.generoId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(peliculaId, generoId);
    }

}