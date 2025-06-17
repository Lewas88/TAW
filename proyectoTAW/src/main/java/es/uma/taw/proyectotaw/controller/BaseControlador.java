package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.GeneroRepository;
import es.uma.taw.proyectotaw.dao.PeliculaRepository;
import es.uma.taw.proyectotaw.entity.Genero;
import es.uma.taw.proyectotaw.entity.Pelicula;
import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BaseControlador {
    @Autowired protected PeliculaRepository peliculaRepository;
    @Autowired protected GeneroRepository generoRepository;

    @GetMapping("/") //Julian y Daniel
    public String doHome(Model model) {
        List<Pelicula> top10 = peliculaRepository.findTopRatedByReviews(PageRequest.of(0, 10));
        model.addAttribute("peliculasRecomendadas", top10);

        List<Pelicula> topPeliculas = peliculaRepository.findTopRatedByRating(PageRequest.of(0, 20));
        model.addAttribute("topPeliculas", topPeliculas);

        List<Genero> generos = generoRepository.findAll();
        Map<String, List<Pelicula>> peliculasPorGenero = new HashMap<>();
        for (Genero genero : generos) {
            String nombreGenero = genero.getNombre();
            List<Pelicula> peliculasGenero = peliculaRepository.findPeliculasByGenero(nombreGenero.toLowerCase(), PageRequest.of(0, 20));
            peliculasPorGenero.put(nombreGenero, peliculasGenero);
        }

        model.addAttribute("peliculasPorGenero", peliculasPorGenero);

        return "home";
    }

    @PostMapping("/buscar")//Julian
    public String doBuscar(@RequestParam("busqueda") String busqueda) {
        String s = busqueda;
        return "redirect:/";
    }
}
