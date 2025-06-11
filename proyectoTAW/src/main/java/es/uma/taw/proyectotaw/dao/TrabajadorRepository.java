package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Review;
import es.uma.taw.proyectotaw.entity.Trabajador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface TrabajadorRepository extends JpaRepository<Trabajador, Integer> {
    @Query("SELECT t FROM Trabajador t WHERE " +
            "(:keyword IS NULL OR LOWER(t.nombre) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
            "(:keyword2 IS NULL OR LOWER(t.puesto) LIKE LOWER(CONCAT('%', :keyword2, '%'))) AND " +
            "(:keyword2 IS NULL OR LOWER(t.departamento) LIKE LOWER(CONCAT('%', :keyword3, '%'))) ")
    List<Trabajador> filtrarTrabajadores(
            @Param("keyword") String keyword,
            @Param("keyword2") String keyword2,
            @Param("keyword3") String keyword3
    );
}
