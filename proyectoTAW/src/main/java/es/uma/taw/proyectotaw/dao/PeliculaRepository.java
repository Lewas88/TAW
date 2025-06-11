package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Pelicula;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PeliculaRepository extends JpaRepository<Pelicula, Integer> {
    @Query("SELECT r.pelicula FROM Review r GROUP BY r.pelicula ORDER BY AVG(r.califica) DESC")
    List<Pelicula> findTopRated(Pageable pageable);
}
