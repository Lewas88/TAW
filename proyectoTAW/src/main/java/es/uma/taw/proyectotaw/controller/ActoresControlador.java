package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.ActorRepository;
import es.uma.taw.proyectotaw.dao.CastingRepository;
import es.uma.taw.proyectotaw.dao.PeliculaRepository;
import es.uma.taw.proyectotaw.entity.Actor;
import es.uma.taw.proyectotaw.entity.Casting;
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

    @Autowired protected CastingRepository castingRepository;

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
        model.addAttribute("casting", this.castingRepository.findByActorId(id));
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
    @GetMapping("/editarCasting")//Enrique
    public String doEditarCasting(@RequestParam(value = "id", defaultValue = "-1" )Integer id,  Model model) {
        Actor actor = this.actorRepository.findById(id).orElse(new Actor());
        model.addAttribute("actor", actor);
        model.addAttribute("peliculas", this.peliculaRepository.findAll());
        model.addAttribute("peliculasParticipadas", this.peliculaRepository.findPeliculasByActorId(id));
        model.addAttribute("casting", this.castingRepository.findByActorId(id));
        return "editarActorCasting";
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


    //ENRIQUE
    @PostMapping("/guardarParticipaciones")
    public String guardarParticipaciones(
            @RequestParam("id") Integer actorId,
            @RequestParam(value = "peliculasParticipadas", required = false) List<Integer> peliculasIds,
            @RequestParam(value = "personaje", required = false) List<String> personajes,
            Model model
    ) {
        Actor actor = this.actorRepository.findById(actorId).orElse(null);
        if (actor == null) {
            return "redirect:/actores/";
        }

        List<Casting> castingsActuales = this.castingRepository.findByActorId(actorId);
        this.castingRepository.deleteAll(castingsActuales);

        if (peliculasIds != null) {
            for (int i = 0; i < peliculasIds.size(); i++) {
                Integer peliculaId = peliculasIds.get(i);
                Pelicula pelicula = this.peliculaRepository.findById(peliculaId).orElse(null);
                if (pelicula != null) {
                    String personaje = (personajes != null && personajes.size() > i) ? personajes.get(i) : "";

                    es.uma.taw.proyectotaw.entity.CastingId castingId = new es.uma.taw.proyectotaw.entity.CastingId();
                    castingId.setActorId(actor.getId());
                    castingId.setPeliculaId(pelicula.getId());

                    Casting casting = new Casting();
                    casting.setId(castingId);
                    casting.setActor(actor);
                    casting.setPelicula(pelicula);
                    casting.setPersonaje(personaje != null ? personaje : "");
                    this.castingRepository.save(casting);
                }
            }
        }

        return "redirect:/actores/ver?id=" + actorId;
    }

    //Julian
    @GetMapping("/buscarActores")
    public String doBuscarActores(@RequestParam("busquedaNombreActor") String nombre, HttpSession session, Model model) {
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        model.addAttribute("actors", actorRepository.filtrarActores(nombre,null,null));
        return "actores";
    }
}
