package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Pelicula;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface PeliculaRepository extends JpaRepository<Pelicula, Integer> {
    @Query("SELECT r.pelicula FROM Review r GROUP BY r.pelicula ORDER BY AVG(r.califica) DESC")
    List<Pelicula> findTopRated(Pageable pageable);

    @Query("SELECT p FROM Pelicula p WHERE " +
            "(:keyword IS NULL OR LOWER(p.titulo) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
            "(:minIngresos IS NULL OR p.ingresos >= :minIngresos) AND " +
            "(:maxIngresos IS NULL OR p.ingresos <= :maxIngresos) AND " +
            "(:minPresupuesto IS NULL OR p.presupuesto >= :minPresupuesto) AND " +
            "(:maxPresupuesto IS NULL OR p.presupuesto <= :maxPresupuesto) AND " +
            "(:fechaInicio IS NULL OR p.fechaEstreno >= :fechaInicio) AND " +
            "(:fechaFin IS NULL OR p.fechaEstreno <= :fechaFin) AND " +
            "(:minRating IS NULL OR p.rating >= :minRating) AND " +
            "(:minDuracion IS NULL OR p.duracion >= :minDuracion) AND " +
            "(:maxDuracion IS NULL OR p.duracion <= :maxDuracion)")
    List<Pelicula> filtrarPeliculas(
            @Param("keyword") String keyword,
            @Param("minIngresos") Long minIngresos,
            @Param("maxIngresos") Long maxIngresos,
            @Param("minPresupuesto") Long minPresupuesto,
            @Param("maxPresupuesto") Long maxPresupuesto,
            @Param("fechaInicio") LocalDate fechaInicio,
            @Param("fechaFin") LocalDate fechaFin,
            @Param("minRating") Double minRating,
            @Param("minDuracion") Integer minDuracion,
            @Param("maxDuracion") Integer maxDuracion
    );



}
