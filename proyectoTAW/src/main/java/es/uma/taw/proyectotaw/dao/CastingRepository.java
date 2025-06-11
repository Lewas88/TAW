//Enrique Silveira García

package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.Casting;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CastingRepository extends JpaRepository<Casting, Integer> {

    //Enrique
    @Query("SELECT c FROM Casting c WHERE c.actor.id = :actorId")
    List<Casting> findByActorId(@Param("actorId") Integer actorId);
    //Enrique
    @Query("SELECT c FROM Casting c WHERE c.actor.id = :actorId AND c.pelicula.id = :peliculaId")
    Casting findByActorIdAndPeliculaId(@Param("actorId") Integer actorId, @Param("peliculaId") Integer peliculaId);
}
