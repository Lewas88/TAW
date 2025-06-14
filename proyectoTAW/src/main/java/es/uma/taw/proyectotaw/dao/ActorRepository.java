package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Actor;
import es.uma.taw.proyectotaw.entity.Pelicula;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ActorRepository extends JpaRepository<Actor, Integer> {

    //Enrique: Filtro de busqueda de actores por pelicula
    @Query("SELECT c.actor FROM Casting c WHERE c.pelicula.id = :peliculaId")
    List<Actor> findActoresByPeliculaId(@Param("peliculaId") Integer peliculaId);
    @Query("SELECT a FROM Actor a " +
            "WHERE (:nombre IS NULL OR LOWER(a.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))) " +
            "AND (:minEdad IS NULL OR a.edad >= :minEdad) " +
            "AND (:maxEdad IS NULL OR a.edad <= :maxEdad)")
    List<Actor> filtrarActores(@Param("nombre") String nombre,
                               @Param("minEdad") Integer minEdad,
                               @Param("maxEdad") Integer maxEdad);

    @Query("SELECT a.nombre, COUNT(c) FROM Casting c JOIN c.actor a GROUP BY a ORDER BY COUNT(c) DESC")
    List<Object[]> findTop5ActoresConMasPeliculas(Pageable pageable);
}
