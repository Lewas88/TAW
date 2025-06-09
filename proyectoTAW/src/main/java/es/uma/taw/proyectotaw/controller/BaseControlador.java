package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.PeliculaRepository;
import es.uma.taw.proyectotaw.entity.Pelicula;
import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class BaseControlador {
    @Autowired protected PeliculaRepository peliculaRepository;

    @GetMapping("/")//Julian
    public String doHome(HttpSession session, Model model) {
        List<Pelicula> top10 = peliculaRepository.findTopRated(PageRequest.of(0, 10));
        model.addAttribute("peliculasRecomendadas", top10);
        model.addAttribute("peliculas", peliculaRepository.findAll());
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        return "home";
    }

    @PostMapping("/buscar")//Julian
    public String doBuscar(@RequestParam("busqueda") String busqueda) {
        String s = busqueda;
        return "redirect:/";
    }
    /*@GetMapping("/peliculas")
    public String doPeliculas() {
        return "peliculas";
    }*/
}
