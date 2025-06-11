package es.uma.taw.proyectotaw.dao;

import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UsuarioRepository extends JpaRepository<UsuarioEntity, Integer> {

    @Query("select u from UsuarioEntity u where u.correo = :correo and u.contrasenaHash = :passwordHash")
    public UsuarioEntity logInUser (@Param("correo") String correo, @Param("passwordHash") String passwordHash);

    @Query("SELECT u FROM UsuarioEntity u " +
            "WHERE (:keyword IS NULL OR u.nombre LIKE %:keyword%) " +
            "AND (:keyword2 IS NULL OR u.correo LIKE %:keyword2%) " +
            "AND (:tipoUsuarioId IS NULL OR u.tipoUsuario.id = :tipoUsuarioId)")
    public List<UsuarioEntity> filtrarUsuarios(
            @Param("keyword") String keyword,
            @Param("keyword2") String keyword2,
            @Param("tipoUsuarioId") Integer tipoUsuarioId);

}
