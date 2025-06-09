//David 100%
package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.ReviewRepository;
import es.uma.taw.proyectotaw.dao.UsuarioRepository;
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
    @GetMapping("/lista")
    public String doListaUsuario(HttpSession session, Model model) {
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        List<UsuarioEntity> usuarios = this.usuarioRepository.findAll();
        model.addAttribute("usuarios",usuarios);
        return "usuarios";
    }


    @GetMapping("/ver")
    public String doVerPerfil(@RequestParam(value = "id")Integer id, HttpSession session, Model model) {
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        return "verUsuario";
    }
    @GetMapping("/editar")
    public String doEditarUsuario(@RequestParam(value = "id")Integer id, HttpSession session, Model model) {
        UsuarioEntity usuario = this.usuarioRepository.findById(id).orElse(new UsuarioEntity());
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        model.addAttribute("usuario", usuario);
        return "editarUsuario";
    }

}
