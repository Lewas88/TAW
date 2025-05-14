package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.ActorRepository;
import es.uma.taw.proyectotaw.dao.PeliculaRepository;
import es.uma.taw.proyectotaw.dao.ReviewRepository;
import es.uma.taw.proyectotaw.dao.UsuarioRepository;
import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/analista")
public class AnalistaController {

    @Autowired
    private UsuarioRepository usuarioRepository;
    @Autowired
    private PeliculaRepository peliculaRepository;
    @Autowired
    private ReviewRepository reviewRepository;
    @Autowired
    private ActorRepository actorRepository;

    @GetMapping("/")
    public String doAnalista(Model model, HttpSession session) {
        UsuarioEntity usuario = (UsuarioEntity) session.getAttribute("user");
        if(usuario == null || usuario.getTipoUsuario().getId() != 3) {
            return "redirect:/login/";
        }
        model.addAttribute("peliculas", peliculaRepository.findAll());
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("actores", actorRepository.findAll());
        model.addAttribute("usuarios",usuarioRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("usuario", usuario);
        model.addAttribute("buscador", 0);
        return "analista";
    }

    @PostMapping("/filtrar")
    public String doFiltrar(Model model, HttpSession session, @RequestParam("entidad") String filtro) {

        return "analista";
    }

    @PostMapping("/elegirBuscadorDePeliculas")
    public String elegirBuscadorDePeliculas(Model model) {
        model.addAttribute("peliculas", peliculaRepository.findAll());
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("actores", actorRepository.findAll());
        model.addAttribute("usuarios",usuarioRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 1);
        return "analista";
    }
    @PostMapping("/elegirBuscadorDeReviews")
    public String elegirBuscadorDeReviews(Model model) {
        model.addAttribute("peliculas", peliculaRepository.findAll());
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("actores", actorRepository.findAll());
        model.addAttribute("usuarios",usuarioRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 2);
        return "analista";
    }
    @PostMapping("/elegirBuscadorDeActores")
    public String elegirBuscadorDeActores(Model model) {
        model.addAttribute("peliculas", peliculaRepository.findAll());
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("actores", actorRepository.findAll());
        model.addAttribute("usuarios",usuarioRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 3);
        return "analista";
    }
    @PostMapping("/elegirBuscadorDeUsuarios")
    public String elegirBuscadorDeUsuarios(Model model) {
        model.addAttribute("peliculas", peliculaRepository.findAll());
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("actores", actorRepository.findAll());
        model.addAttribute("usuarios",usuarioRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 4);
        return "analista";
    }
}
