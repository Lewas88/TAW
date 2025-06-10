package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.ActorRepository;
import es.uma.taw.proyectotaw.dao.PeliculaRepository;
import es.uma.taw.proyectotaw.entity.Actor;
import es.uma.taw.proyectotaw.entity.Pelicula;
import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

//Julian, Enrique y David

@Controller
@RequestMapping("/actores") //Julian
public class ActoresControlador { //Julian
    @Autowired protected ActorRepository actorRepository;

    @Autowired protected PeliculaRepository  peliculaRepository;

    @GetMapping("/")//Julian y David
    public String doListarActores(HttpSession session, Model model) {
        List<Actor> actors = actorRepository.findAll();
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        model.addAttribute("actors", actors);
        return "actores";
    }

    @GetMapping("/ver")//Julian , Enrique y David
    public String doVerActor(@RequestParam(value = "id", defaultValue = "-1" )Integer id, HttpSession session, Model model) {
        Actor actor = this.actorRepository.findById(id).orElse(new Actor());
        List<Pelicula> peliculasParticipadas = peliculaRepository.findPeliculasByActorId(id);
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        model.addAttribute("actor", actor);
        model.addAttribute("peliculasParticipadas", peliculasParticipadas);
        return "verActor";
    }

    @GetMapping("/editar")//Julian
    public String doEditarActor(@RequestParam(value = "id", defaultValue = "-1" )Integer id,  Model model) {
        Actor actor = this.actorRepository.findById(id).orElse(new Actor());
        model.addAttribute("actor", actor);
        model.addAttribute("peliculas", this.peliculaRepository.findAll());
        return "editarActor";
    }
    @PostMapping("/guardar")//Julian
    public String doGuardarActor(@RequestParam("id")Integer id,
                                 @RequestParam("nombre")String nombre,
                                 @RequestParam("edad")Integer edad,
                                 Model model) {
        Actor actor = this.actorRepository.findById(id).orElse(new Actor());
        actor.setNombre(nombre);
        actor.setEdad(edad);
        this.actorRepository.save(actor);
        return "redirect:/actores/";
    }
    @GetMapping("/borrar")//Julian
    public String doBorrarActor(@RequestParam("id")Integer id) {
        this.actorRepository.deleteById(id);
        return "redirect:/actores/";
    }
}
