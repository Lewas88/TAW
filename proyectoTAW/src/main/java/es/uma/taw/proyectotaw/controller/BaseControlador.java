package es.uma.taw.proyectotaw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BaseControlador {
    @GetMapping("/")
    public String doHome() {
        return "home";
    }

    @PostMapping("/buscar")
    public String doBuscar(@RequestParam("busqueda") String busqueda) {
        String s = busqueda;
        return "redirect:/";
    }
    /*@GetMapping("/peliculas")
    public String doPeliculas() {
        return "peliculas";
    }*/
}
