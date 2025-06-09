package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Pelicula;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PeliculaRepository extends JpaRepository<Pelicula, Integer> {
    @Query("SELECT r.pelicula FROM Review r GROUP BY r.pelicula ORDER BY AVG(r.califica) DESC")
    List<Pelicula> findTopRated(Pageable pageable);

    //Enrique 
    @Query("SELECT c.pelicula FROM Casting c WHERE c.actor.id = :actorId")
    List<Pelicula> findPeliculasByActorId(@Param("actorId") Integer actorId);
    //Enrique
    @Query("SELECT p FROM Pelicula p WHERE p.id NOT IN (SELECT c.pelicula.id FROM Casting c WHERE c.actor.id = :actorId)")
    List<Pelicula> findPeliculasActorNoParticipa(@Param("actorId") Integer actorId);
    //Enrique
    @Query("SELECT tp.pelicula FROM TrabajadorPelicula tp WHERE tp.trabajador.id = :trabajadorId")
    List<Pelicula> findPeliculasByTrabajadorId(@Param("trabajadorId") Integer trabajadorId);
    //Enrique
    @Query("SELECT p FROM Pelicula p WHERE p.id NOT IN (SELECT tp.pelicula.id FROM TrabajadorPelicula tp WHERE tp.trabajador.id = :trabajadorId)")
    List<Pelicula> findPeliculasTrabajadorNoParticipa(@Param("trabajadorId") Integer trabajadorId);


}
