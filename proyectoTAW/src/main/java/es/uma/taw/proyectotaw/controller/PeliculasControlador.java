package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.*;
import es.uma.taw.proyectotaw.entity.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;

// Daniel Linares y Enrique Silveira

@Controller
@RequestMapping("/peliculas")
public class PeliculasControlador {
    @Autowired protected PeliculaRepository peliculaRepository;
    @Autowired protected ReviewRepository reviewRepository;
    @Autowired protected ActorRepository actorRepository;
    @Autowired protected TrabajadorRepository trabajadorRepository;

    @GetMapping("/")
    public String doIndex(HttpSession session, Model model) {
        model.addAttribute("peliculas", peliculaRepository.findAll());
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user", user);
        return "peliculas";
    }

    @GetMapping("/ver")
    public String doVer(@RequestParam(value = "id")Integer id, HttpSession session, Model model) {
        Pelicula pelicula = this.peliculaRepository.findById(id).orElse(null);
        model.addAttribute("pelicula", pelicula);
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user", user);
        model.addAttribute("reviews", reviewRepository.findAll());
        return "verPelicula";
    }

    @GetMapping("/casting")
    public String doCasting(@RequestParam(value = "id")Integer id, HttpSession session, Model model) {
        Pelicula pelicula = this.peliculaRepository.findById(id).orElse(null);
        List<Actor> cast = this.actorRepository.findActoresByPeliculaId(id);
        List<Trabajador> trabajadores = this.trabajadorRepository.findTrabajadoresByPeliculaId(id);
        model.addAttribute("pelicula", pelicula);
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user", user);
        model.addAttribute("casting", cast);
        model.addAttribute("trabajadores", trabajadores);

        return "verCastingPelicula";
    }

    @PostMapping("/anyadirReview")
    public String doAnyadirReview(@RequestParam(value = "idPelicula")Integer id,
                                  @RequestParam("puntuacion")Double puntuacion,
                                  @RequestParam("opinion")String opinion,
                                  HttpSession session,
                                  Model model) {
        Review review = new Review();
        review.setPelicula(this.peliculaRepository.findById(id).orElse(null));
        review.setCalifica(puntuacion);
        review.setComentario(opinion);
        review.setFecha(LocalDate.now());
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        review.setUsuario(user);
        reviewRepository.save(review);
        return "redirect:/peliculas/ver?id=" + id;
    }

    @PostMapping("/borrarReview")
    public String doBorrarReview(@RequestParam("idReview")Integer idR,
                                 Model model) {
        Review review = this.reviewRepository.findById(idR).orElse(null);
        Integer idPelicula = review.getPelicula().getId();
        reviewRepository.delete(review);
        return "redirect:/peliculas/ver?id=" + idPelicula;
    }

    @GetMapping("/editar")
    public String doEditarPelicula(@RequestParam(value = "id", defaultValue = "-1") Integer id, Model model) {
        Pelicula pelicula = this.peliculaRepository.findById(id).orElse(new Pelicula());
        model.addAttribute("pelicula", pelicula);
        return "editarPelicula";
    }

    @PostMapping("/guardar")
    public String doGuardarPelicula(
            @RequestParam("id") Integer id,
            @RequestParam("titulo") String titulo,
            @RequestParam("sinopsis") String sinopsis,
            @RequestParam("estreno") String estreno,
            @RequestParam("duracion") Integer duracion,
            @RequestParam("presupuesto") Integer presupuesto,
            @RequestParam("ingresos") Long ingresos,
            Model model
    ) {
        Pelicula pelicula = this.peliculaRepository.findById(id).orElse(new Pelicula());
        pelicula.setTitulo(titulo);
        pelicula.setSinopsis(sinopsis);
        pelicula.setDuracion(duracion);
        pelicula.setPresupuesto(presupuesto);
        pelicula.setIngresos(ingresos);
        if (estreno != null && !estreno.isEmpty()) {
            pelicula.setFechaEstreno(java.time.LocalDate.parse(estreno));
        }
        this.peliculaRepository.save(pelicula);

        int nuevoid = pelicula.getId();
        return "redirect:/peliculas/ver?id=" + nuevoid;
    }

    // Julian y Daniel
    @GetMapping("/buscarPeliculas")
    public String doBuscarPeliculas(@RequestParam(value = "busquedaNombrePelicula", required = false) String nombre,
                                    HttpSession session,
                                    Model model) {
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user", user);

        if (nombre != null && !nombre.isBlank()) {
            model.addAttribute("peliculas", peliculaRepository.findAPeliculasLike(nombre));
        } else {
            model.addAttribute("peliculas", peliculaRepository.findAll());
        }

        return "peliculas";
    }

    @GetMapping("/borrar")//Enrique
    public String doBorrarPelicula(@RequestParam("id")Integer id) {
        this.peliculaRepository.deleteById(id);
        return "redirect:/peliculas/";
    }
}

