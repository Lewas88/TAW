package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.TipoUsuarioRepository;
import es.uma.taw.proyectotaw.dao.UsuarioRepository;
import es.uma.taw.proyectotaw.entity.TipoUsuario;
import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import es.uma.taw.proyectotaw.ui.Usuario;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

@Controller
@RequestMapping("/login")//Julian
public class LoginControlador {
    @Autowired private UsuarioRepository usuarioRepository;
    @Autowired private TipoUsuarioRepository tipoUsuarioRepository;

    @GetMapping("/")//Julian
    public String doInit(HttpSession session, Model model) {
        model.addAttribute("usuario", new Usuario());
        return "login";
    }

    @GetMapping("/signIn")//Julian
    public String doSignIn() {
        return "signin";
    }

    @PostMapping("/autentica")//Julian
    public String doLogIn(@ModelAttribute Usuario usuario, HttpSession session, Model model) {
        String pwd = usuario.getPassword();
        String hashPwd = hashPassword(pwd);
        UsuarioEntity user = this.usuarioRepository.logInUser(usuario.getCorreo(), hashPwd);
        if (user == null) {
            model.addAttribute("error", "Incorrecto");
            return "login";
        } else {
            session.setAttribute("user", user);
            return "redirect:/";
        }
    }

    @PostMapping("/registra")//Julian Enrique y Daniel
    public String doRegister(@RequestParam("nombre")String nombre,
                             @RequestParam("correo")String correo,
                             @RequestParam("contrasena")String contrasena,
                             @RequestParam("confirm")String contrasenaConfirm,
                             Model model) {
        if (!contrasena.equals(contrasenaConfirm)) {
            model.addAttribute("error", "Las contraseñas deben coincidir");
            return "signin";
        }
        // Contraseña hasheada
        String hashPwd = hashPassword(contrasena);

        // Creamos el usuario y le pasamos nombre correo y contraseña ya hasheada
        UsuarioEntity user = new UsuarioEntity();
        user.setNombre(nombre);
        user.setCorreo(correo);
        user.setContrasenaHash(hashPwd);
        //Enrique
        TipoUsuario estandar = tipoUsuarioRepository.findById(2).orElse(null);
        user.setTipoUsuario(estandar);
        // Guardar en la BD
        this.usuarioRepository.save(user);

        return "redirect:/login/";
    }
    //Julian y Daniel
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @GetMapping("/logout")//Julian
    public String doLogOut(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }
}
