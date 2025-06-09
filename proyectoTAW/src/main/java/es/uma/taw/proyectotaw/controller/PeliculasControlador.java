package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.PeliculaRepository;
import es.uma.taw.proyectotaw.dao.ReviewRepository;
import es.uma.taw.proyectotaw.entity.Pelicula;
import es.uma.taw.proyectotaw.entity.Review;
import es.uma.taw.proyectotaw.entity.UsuarioEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;

// Daniel Linares 100%

@Controller
@RequestMapping("/peliculas")
public class PeliculasControlador {
    @Autowired protected PeliculaRepository peliculaRepository;
    @Autowired protected ReviewRepository reviewRepository;

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

    @PostMapping("/recomendar")
    public String doRecomendar(@RequestParam(value = "id")Integer id, Model model) {
        Pelicula pelicula = this.peliculaRepository.findById(id).orElse(null);

        return "redirect:/peliculas/";
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
}

