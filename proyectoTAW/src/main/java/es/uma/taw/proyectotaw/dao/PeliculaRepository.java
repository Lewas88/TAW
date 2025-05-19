package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.PeliculaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface PeliculaRepository extends JpaRepository<PeliculaEntity, Integer> {

    @Query("SELECT p FROM PeliculaEntity p ORDER BY p.ingresos DESC")
    List<PeliculaEntity> obtenerPeliculasPorIngresosDesc();

    @Query("SELECT p FROM PeliculaEntity p ORDER BY p.ingresos ASC")
    List<PeliculaEntity> obtenerPeliculasPorIngresosAsc();

    @Query("SELECT p FROM PeliculaEntity p ORDER BY p.rating DESC")
    List<PeliculaEntity> obtenerPeliculasPorRatingDesc();

    @Query("SELECT p FROM PeliculaEntity p ORDER BY p.fechaEstreno DESC")
    List<PeliculaEntity> obtenerPeliculasPorFechaEstrenoDesc();
}
