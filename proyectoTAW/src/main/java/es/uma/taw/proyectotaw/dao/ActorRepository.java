package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Actor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ActorRepository extends JpaRepository<Actor, Integer> {

    //Enrique: Filtro de busqueda de actores por pelicula
    @Query("SELECT c.actor FROM Casting c WHERE c.pelicula.id = :peliculaId")
    List<Actor> findActoresByPeliculaId(@Param("peliculaId") Integer peliculaId);
}
