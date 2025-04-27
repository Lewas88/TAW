package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.PeliculaRepository;
import es.uma.taw.proyectotaw.entity.PeliculaEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/peliculas")
public class PeliculasControlador {
    @Autowired
    PeliculaRepository peliculaRepository;

    @GetMapping("/")
    public String doIndex(Model model) {
        model.addAttribute("peliculas", peliculaRepository.findAll());
        return "peliculas";
    }

    @PostMapping("/ver")
    public String doVer(@RequestParam(value = "id")Integer id, Model model) {
        PeliculaEntity pelicula = this.peliculaRepository.findById(id).orElse(null);
        model.addAttribute("pelicula", pelicula);
        return "verPelicula";
    }
}

