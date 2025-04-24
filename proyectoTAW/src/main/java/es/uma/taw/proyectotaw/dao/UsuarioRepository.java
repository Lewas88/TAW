package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UsuarioRepository extends JpaRepository<UsuarioEntity, Integer> {

    @Query("select u from UsuarioEntity u where u.correo = :correo and u.contrasenaHash = :passwordHash")
    public UsuarioEntity logInUser (@Param("correo") String correo, @Param("passwordHash") String passwordHash);
}
