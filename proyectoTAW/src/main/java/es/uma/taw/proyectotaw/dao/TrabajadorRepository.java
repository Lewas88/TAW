package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Trabajador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TrabajadorRepository extends JpaRepository<Trabajador, Integer> {
    // Enrique: Filtro de busqueda de trabajadores por pelicula
    @Query("SELECT t FROM Trabajador t WHERE t.id IN (SELECT tp.trabajador.id FROM TrabajadorPelicula tp WHERE tp.pelicula.id = :peliculaId)")
    List<Trabajador> findTrabajadoresByPeliculaId(@Param("peliculaId") Integer peliculaId);
}
