package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/analista")
public class AnalistaController {

    @GetMapping("/")
    public String doAnalista(Model model, HttpSession session) {
        UsuarioEntity usuario = (UsuarioEntity) session.getAttribute("user");
        if(usuario == null || usuario.getTipoUsuario().getId() != 3) {
            return "redirect:/login/";
        }
        model.addAttribute("usuario", usuario);
        return "analista";
    }
}
