package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.ActorRepository;
import es.uma.taw.proyectotaw.entity.Actor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class Controlador {
    @Autowired protected ActorRepository actorRepository;
    @GetMapping("/")
    public String index(Model model) {
        List<Actor> actors = actorRepository.findAll();
        model.addAttribute("actors", actors);
        return "actores";
    }
}
