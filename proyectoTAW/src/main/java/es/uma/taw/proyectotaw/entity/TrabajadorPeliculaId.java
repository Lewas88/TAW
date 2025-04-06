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
public class TrabajadorPeliculaId implements java.io.Serializable {
    private static final long serialVersionUID = 8123835469117668111L;
    @Column(name = "Trabajador_ID", nullable = false)
    private Integer trabajadorId;

    @Column(name = "Pelicula_ID", nullable = false)
    private Integer peliculaId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        TrabajadorPeliculaId entity = (TrabajadorPeliculaId) o;
        return Objects.equals(this.peliculaId, entity.peliculaId) &&
                Objects.equals(this.trabajadorId, entity.trabajadorId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(peliculaId, trabajadorId);
    }

}