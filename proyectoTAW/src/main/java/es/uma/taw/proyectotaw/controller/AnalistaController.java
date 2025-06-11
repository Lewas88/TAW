package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.*;
import es.uma.taw.proyectotaw.entity.FiltrosPelicula;
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

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

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
    @Autowired
    private TrabajadorRepository trabajadorRepository;
    @Autowired
    private CastingRepository castingRepository;

    @GetMapping("/")
    public String doAnalista(Model model, HttpSession session) {
        UsuarioEntity usuario = (UsuarioEntity) session.getAttribute("user");
        if(usuario == null || usuario.getTipoUsuario().getId() != 5) {
            return "redirect:/login/";
        }
        FiltrosPelicula filtros = (FiltrosPelicula) session.getAttribute("filtrosPelicula");
        if (filtros != null) {
            model.addAttribute("filtros", filtros);
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

    @PostMapping("/filtrarPeliculas")
    public String doFiltrarPeliculas(Model model, HttpSession session, @RequestParam(required = false) String keyword,
                                     @RequestParam(required = false) Long minIngresos,
                                     @RequestParam(required = false) Long maxIngresos,
                                     @RequestParam(required = false) Long minPresupuesto,
                                     @RequestParam(required = false) Long maxPresupuesto,
                                     @RequestParam(required = false) String fechaInicio,
                                     @RequestParam(required = false) String fechaFin,
                                     @RequestParam(required = false) Double minRating,
                                     @RequestParam(required = false) Integer minDuracion,
                                     @RequestParam(required = false) Integer maxDuracion,
                                     @RequestParam(required = false) String orden
    ) {
        UsuarioEntity usuario = (UsuarioEntity) session.getAttribute("user");
        if (usuario == null || usuario.getTipoUsuario().getId() != 5) {
            return "redirect:/login/";
        }

        FiltrosPelicula filtros = new FiltrosPelicula();
        filtros.setKeyword(keyword);
        filtros.setMinIngresos(minIngresos);
        filtros.setMaxIngresos(maxIngresos);
        filtros.setMinPresupuesto(minPresupuesto);
        filtros.setMaxPresupuesto(maxPresupuesto);
        filtros.setFechaInicio(fechaInicio);
        filtros.setFechaFin(fechaFin);
        filtros.setMinRating(minRating);
        filtros.setMinDuracion(minDuracion);
        filtros.setMaxDuracion(maxDuracion);

        session.setAttribute("filtrosPelicula", filtros);

        LocalDate fechaInicioLD = null;
        LocalDate fechaFinLD = null;
        try {
            if (fechaInicio != null && !fechaInicio.isEmpty()) {
                fechaInicioLD = LocalDate.parse(fechaInicio);
            }
            if (fechaFin != null && !fechaFin.isEmpty()) {
                fechaFinLD = LocalDate.parse(fechaFin);
            }
        } catch (DateTimeParseException e) {
            // Manejar error de formato de fecha si es necesario
            model.addAttribute("error", "Formato de fecha inválido");
            return "analista";
        }

        List<Pelicula> peliculasFiltradas = peliculaRepository.filtrarPeliculas(
                keyword, minIngresos, maxIngresos, minPresupuesto, maxPresupuesto,
                fechaInicioLD, fechaFinLD, minRating, minDuracion, maxDuracion
        );
        // Después ordenar
        if (orden != null && !orden.isEmpty()) {
            switch (orden) {
                case "ingresosDesc":
                    peliculasFiltradas.sort((p1, p2) -> p2.getIngresos().compareTo(p1.getIngresos()));
                    break;
                case "ingresosAsc":
                    peliculasFiltradas.sort((p1, p2) -> p1.getIngresos().compareTo(p2.getIngresos()));
                    break;
                case "presupuestoDesc":
                    peliculasFiltradas.sort((p1, p2) -> p2.getPresupuesto().compareTo(p1.getPresupuesto()));
                    break;
                case "presupuestoAsc":
                    peliculasFiltradas.sort((p1, p2) -> p1.getPresupuesto().compareTo(p2.getPresupuesto()));
                    break;
                case "ratingDesc":
                    peliculasFiltradas.sort((p1, p2) -> p2.getRating().compareTo(p1.getRating()));
                    break;
                case "ratingAsc":
                    peliculasFiltradas.sort((p1, p2) -> p1.getRating().compareTo(p2.getRating()));
                    break;
                case "fechaDesc":
                    peliculasFiltradas.sort((p1, p2) -> p2.getFechaEstreno().compareTo(p1.getFechaEstreno()));
                    break;
                case "fechaAsc":
                    peliculasFiltradas.sort((p1, p2) -> p1.getFechaEstreno().compareTo(p2.getFechaEstreno()));
                    break;
                case "duracionDesc":
                    peliculasFiltradas.sort((p1, p2) -> p2.getDuracion().compareTo(p1.getDuracion()));
                    break;
                case "duracionAsc":
                    peliculasFiltradas.sort((p1, p2) -> p1.getDuracion().compareTo(p2.getDuracion()));
                    break;
            }
            session.setAttribute("ordenSeleccionado", orden);
        }

        if (orden != null) {
            session.setAttribute("ordenSeleccionado", orden);
        }
        model.addAttribute("ordenSeleccionado", session.getAttribute("ordenSeleccionado"));
        model.addAttribute("peliculas", peliculasFiltradas);
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("actores", actorRepository.findAll());
        model.addAttribute("usuarios", usuarioRepository.findAll());
        model.addAttribute("totalPeliculas", Long.valueOf(peliculasFiltradas.size()));
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("usuario", usuario);
        model.addAttribute("buscador", 1);
        model.addAttribute("ordenSeleccionado", orden);
        model.addAttribute("filtros", filtros);
        return "analista";
    }

    @PostMapping("/borrarFiltros")
    public String borrarFiltros(Model model, HttpSession session) {
        UsuarioEntity usuario = (UsuarioEntity) session.getAttribute("user");
        if (usuario == null || usuario.getTipoUsuario().getId() != 5) {
            return "redirect:/login/";
        }

        // Eliminar filtros y orden de la sesión
        session.removeAttribute("filtrosPelicula");
        session.removeAttribute("ordenSeleccionado");

        // Añadir todos los datos necesarios al modelo
        model.addAttribute("peliculas", peliculaRepository.findAll());
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("actores", actorRepository.findAll());
        model.addAttribute("usuarios", usuarioRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("usuario", usuario);
        model.addAttribute("buscador", 1);

        return "analista";
    }


    @PostMapping("/elegirBuscadorDePeliculas")
    public String elegirBuscadorDePeliculas(Model model, HttpSession session) {
        FiltrosPelicula filtros = (FiltrosPelicula) session.getAttribute("filtrosPelicula");
        if (filtros != null) {
            model.addAttribute("filtros", filtros);
        }
//        model.addAttribute("peliculas", peliculaRepository.findAll());
//        model.addAttribute("reviews", reviewRepository.findAll());
//        model.addAttribute("actores", actorRepository.findAll());
//        model.addAttribute("usuarios",usuarioRepository.findAll());
//        model.addAttribute("totalPeliculas", peliculaRepository.count());

//        model.addAttribute("buscador", 1);
//        model.addAttribute("ordenSeleccionado", session.getAttribute("ordenSeleccionado"));
//        return "analista";
        model.addAttribute("peliculas", peliculaRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 1);
        model.addAttribute("ordenSeleccionado", session.getAttribute("ordenSeleccionado"));
        return "analista";

    }
    @PostMapping("/elegirBuscadorDeReviews")
    public String elegirBuscadorDeReviews(Model model) {
        model.addAttribute("reviews", reviewRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 2);
        return "analista";

    }
    @PostMapping("/elegirBuscadorDeActores")
    public String elegirBuscadorDeActores(Model model) {
        model.addAttribute("actores", actorRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 3);
        return "analista";

    }
    @PostMapping("/elegirBuscadorDeUsuarios")
    public String elegirBuscadorDeUsuarios(Model model) {
        model.addAttribute("usuarios", usuarioRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 4);
        return "analista";

    }

    @PostMapping("/elegirBuscadorDeTrabajadores")
    public String elegirBuscadorDeTrabajadores(Model model) {
        model.addAttribute("trabajadores", trabajadorRepository.findAll());
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("buscador", 5);
        return "analista";
    }
}