package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Pelicula;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface PeliculaRepository extends JpaRepository<Pelicula, Integer> {
    //Julian
    @Query("SELECT pL from Pelicula pL WHERE LOWER(pL.titulo) LIKE LOWER(CONCAT('%',:nombreLike,'%') )")
    List<Pelicula> findAPeliculasLike(@Param("nombreLike") String nombreLike);
    //Daniel Linares
    @Query("SELECT r.pelicula FROM Review r GROUP BY r.pelicula ORDER BY AVG(r.califica) DESC")
    List<Pelicula> findTopRatedByReviews(Pageable pageable);
    //Daniel Linares
    @Query("SELECT gp.pelicula FROM GeneroPelicula gp WHERE LOWER(gp.genero.nombre) = LOWER(:nombreGenero)")
    List<Pelicula> findPeliculasByGenero(@Param("nombreGenero") String nombreGenero, Pageable pageable);
    //Daniel Linares
    @Query("SELECT p FROM Pelicula p ORDER BY p.rating DESC")
    List<Pelicula> findTopRatedByRating(Pageable pageable);
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

    @Query("SELECT COUNT(p) FROM Pelicula p WHERE p.rating >= :min AND p.rating < :max")
    int countByRatingBetween(@Param("min") double min, @Param("max") double max);

    @Query("SELECT p.titulo, (p.ingresos - p.presupuesto) AS utilidad FROM Pelicula p ORDER BY utilidad DESC")
    List<Object[]> findTop5PeliculasPorUtilidad(Pageable pageable);
}
