package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.TipoUsuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface TipoUsuarioRepository extends JpaRepository<TipoUsuario, Integer> {
}
