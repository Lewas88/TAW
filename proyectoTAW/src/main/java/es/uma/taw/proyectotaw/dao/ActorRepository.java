package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Actor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface ActorRepository extends JpaRepository<Actor, Integer> {
}
