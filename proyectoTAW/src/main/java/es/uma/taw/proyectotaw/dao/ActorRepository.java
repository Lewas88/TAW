package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Actor;
import es.uma.taw.proyectotaw.entity.Pelicula;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ActorRepository extends JpaRepository<Actor, Integer> {
    @Query("SELECT a FROM Actor a " +
            "WHERE (:nombre IS NULL OR LOWER(a.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))) " +
            "AND (:minEdad IS NULL OR a.edad >= :minEdad) " +
            "AND (:maxEdad IS NULL OR a.edad <= :maxEdad)")
    List<Actor> filtrarActores(@Param("nombre") String nombre,
                               @Param("minEdad") Integer minEdad,
                               @Param("maxEdad") Integer maxEdad);
}

