package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Trabajador;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TrabajadorRepository extends JpaRepository<Trabajador, Integer> {
}
