package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.PeliculaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PeliculaRepository extends JpaRepository<PeliculaEntity, Integer> {
}
