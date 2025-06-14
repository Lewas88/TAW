package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Pelicula;
import es.uma.taw.proyectotaw.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Integer> {
    @Query("SELECT r FROM Review r WHERE " +
            "(:keyword IS NULL OR LOWER(r.pelicula) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
            "(:keyword2 IS NULL OR LOWER(r.usuario) LIKE LOWER(CONCAT('%', :keyword2, '%'))) AND " +
            "(:fechaInicio IS NULL OR r.fecha >= :fechaInicio) AND " +
            "(:fechaFin IS NULL OR r.fecha <= :fechaFin) AND " +
            "(:minRating IS NULL OR r.califica >= :minRating)")
    List<Review> filtrarReviews(
            @Param("keyword") String keyword,
            @Param("keyword2") String keyword2,
            @Param("fechaInicio") LocalDate fechaInicio,
            @Param("fechaFin") LocalDate fechaFin,
            @Param("minRating") Double minRating
    );
}
