//David 100%
package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.ReviewRepository;
import es.uma.taw.proyectotaw.dao.TipoUsuarioRepository;
import es.uma.taw.proyectotaw.dao.UsuarioRepository;
import es.uma.taw.proyectotaw.entity.TipoUsuario;
import es.uma.taw.proyectotaw.entity.Trabajador;
import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/usuario")
public class UsuarioControlador {
    @Autowired protected UsuarioRepository usuarioRepository;
    @Autowired
    private TipoUsuarioRepository tipoUsuarioRepository;

    @GetMapping("/")
    public String doListaUsuario(HttpSession session, Model model) {
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        List<UsuarioEntity> usuarios = this.usuarioRepository.findAll();
        model.addAttribute("usuarios",usuarios);
        return "usuarios";
    }


    @GetMapping("/ver")
    public String doVerPerfil(@RequestParam(value = "id")Integer id, HttpSession session, Model model) {
        UsuarioEntity usuario = this.usuarioRepository.findById(id).orElse(new UsuarioEntity());
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        List<TipoUsuario> tipoUsuarios = this.tipoUsuarioRepository.findAll();
        model.addAttribute("user",user);
        model.addAttribute("tipoUsuarios",tipoUsuarios);
        model.addAttribute("usuario", usuario);
        return "verUsuario";
    }
    @GetMapping("/editar")
    public String doEditarUsuario(@RequestParam(value = "id" , defaultValue = "-1" )Integer id, HttpSession session, Model model) {
        UsuarioEntity usuario = this.usuarioRepository.findById(id).orElse(new UsuarioEntity());
        if (usuario.getId() == null) {
            // Nuevo usuario
            TipoUsuario tipoDefault = tipoUsuarioRepository.findById(2).orElse(null); // Por ejemplo, ID 2: cliente
            usuario.setTipoUsuario(tipoDefault);
        }
        List<TipoUsuario> tipoUsuarios = this.tipoUsuarioRepository.findAll();
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        model.addAttribute("tipoUsuarios",tipoUsuarios);
        model.addAttribute("usuario", usuario);
        return "editarUsuario";
    }

    @PostMapping("/guardar")
    public String doGuardarUsuario(@RequestParam("id")Integer id,
                                      @RequestParam("nombre")String nombre,
                                      @RequestParam("correo")String correo,
                                      @RequestParam("tipoUsuario") TipoUsuario tipoUsuario,
                                      Model model) {
        UsuarioEntity usuario = this.usuarioRepository.findById(id).orElse(new UsuarioEntity());
        usuario.setNombre(nombre);
        usuario.setCorreo(correo);
        if (id  == -1 ) {
            usuario.setContrasenaHash("8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918");
        }
        usuario.setTipoUsuario(tipoUsuario);
        this.usuarioRepository.save(usuario);
        return "redirect:/";
    }

    @GetMapping("/borrar")
    public String doBorrarUsuario(@RequestParam("id")Integer id) {
        this.usuarioRepository.deleteById(id);
        return "redirect:/usuario/";
    }
}
