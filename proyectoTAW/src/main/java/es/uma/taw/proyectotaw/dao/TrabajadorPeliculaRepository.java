package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.TrabajadorPelicula;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TrabajadorPeliculaRepository extends JpaRepository<TrabajadorPelicula, Integer> {
    //Enrique
    @Query("SELECT tp FROM TrabajadorPelicula tp WHERE tp.trabajador.id = :trabajadorId")
    List<TrabajadorPelicula> findByTrabajadorId(@Param("trabajadorId") Integer trabajadorId);
}
