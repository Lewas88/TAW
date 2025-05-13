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
public class ListaPeliculaId implements Serializable {
    private static final long serialVersionUID = 6222030914088071409L;
    @Column(name = "Lista_ID", nullable = false)
    private Integer listaId;

    @Column(name = "Pelicula_ID", nullable = false)
    private Integer peliculaId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ListaPeliculaId entity = (ListaPeliculaId) o;
        return Objects.equals(this.peliculaId, entity.peliculaId) &&
                Objects.equals(this.listaId, entity.listaId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(peliculaId, listaId);
    }

}