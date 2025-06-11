package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Casting;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CastingRepository extends JpaRepository<Casting, Integer> {
    @Query("SELECT c FROM Casting c WHERE c.actor.id = :actorId")
    List<Casting> findByActorId(@Param("actorId") Integer actorId);

}
