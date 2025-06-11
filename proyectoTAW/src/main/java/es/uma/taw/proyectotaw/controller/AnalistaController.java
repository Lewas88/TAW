package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.*;
import es.uma.taw.proyectotaw.entity.*;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.mapping.Any;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.PrintWriter;
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

    @PostMapping("/filtrarActores")
    public String doFiltrarActores(Model model, HttpSession session, @RequestParam(required = false) String keyword,
                                     @RequestParam(required = false) Integer minEdad,
                                     @RequestParam(required = false) Integer maxEdad,
                                     @RequestParam(required = false) String orden
    ) {
        UsuarioEntity usuario = (UsuarioEntity) session.getAttribute("user");
        if (usuario == null || usuario.getTipoUsuario().getId() != 5) {
            return "redirect:/login/";
        }

        FiltrosPelicula filtros = new FiltrosPelicula();
        filtros.setKeyword(keyword);
        filtros.setMaxEdad(maxEdad);
        filtros.setMinEdad(minEdad);

        session.setAttribute("filtrosActores", filtros);

        List<Actor> actoresFiltrados = actorRepository.filtrarActores(keyword, minEdad, maxEdad);
        // Después ordenar
        if (orden != null && !orden.isEmpty()) {
            switch (orden) {
                case "ingresosDesc":
                    actoresFiltrados.sort((p1, p2) -> p2.getEdad().compareTo(p1.getEdad()));
                    break;
                case "ingresosAsc":
                    actoresFiltrados.sort((p1, p2) -> p1.getEdad().compareTo(p2.getEdad()));
                    break;
            }
            session.setAttribute("ordenSeleccionado", orden);
        }

        if (orden != null) {
            session.setAttribute("ordenSeleccionado", orden);
        }
        model.addAttribute("ordenSeleccionado", session.getAttribute("ordenSeleccionado"));
        model.addAttribute("actores", actoresFiltrados);
        model.addAttribute("totalPeliculas", peliculaRepository.count());
        model.addAttribute("totalReviews", reviewRepository.count());
        model.addAttribute("totalActores", actorRepository.count());
        model.addAttribute("totalUsuarios", usuarioRepository.count());
        model.addAttribute("usuario", usuario);
        model.addAttribute("buscador", 3);
        model.addAttribute("ordenSeleccionado", orden);
        model.addAttribute("filtros", filtros);
        return "analista";
    }

    @PostMapping("/exportarCSV")
    public void exportarCSV(HttpServletResponse response, @RequestParam Integer tipo, @RequestParam(required = false) List<Integer> ids) throws Exception {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=export.csv");

        if (ids == null || ids.isEmpty()) {
            PrintWriter writer = response.getWriter();
            writer.println("Qué mira' bobo?");
            writer.flush();
            writer.close();
            return;
        }

        PrintWriter writer = response.getWriter();

        switch (tipo) {
            case 1: // Películas
                writer.println("Título,Puntuación,Ingresos,Presupuesto,Fecha de Estreno,Duración");
                List<Pelicula> peliculas = peliculaRepository.findAllById(ids);
                for (Pelicula p : peliculas) {
                    writer.printf("\"%s\",%s,%s,%s,%s,%s%n",
                            p.getTitulo(), p.getRating(), p.getIngresos(), p.getPresupuesto(),
                            p.getFechaEstreno(), p.getDuracion());
                }
                break;

            case 2: // Reviews
                writer.println("Película,Usuario,Puntuación,Comentario,Fecha");
                List<Review> reviews = reviewRepository.findAllById(ids);
                for (Review r : reviews) {
                    writer.printf("\"%s\",\"%s\",%s%n",
                            r.getPelicula().getTitulo(), r.getUsuario().getNombre(), r.getCalifica(), r.getComentario(), r.getFecha());
                }
                break;

            case 3: // Actores
                writer.println("Nombre,Edad");
                List<Actor> actores = actorRepository.findAllById(ids);
                for (Actor a : actores) {
                    writer.printf("\"%s\",%s,\"%s\"%n",
                            a.getNombre(), a.getEdad());
                }
                break;

            case 4: // Usuarios
                writer.println("Nombre,Correo,Tipo Usuario");
                List<UsuarioEntity> usuarios = usuarioRepository.findAllById(ids);
                for (UsuarioEntity u : usuarios) {
                    writer.printf("\"%s\",\"%s\",\"%s\"%n",
                            u.getNombre(), u.getCorreo(), u.getTipoUsuario().getTipo());
                }
                break;

            case 5: // Trabajadores
                writer.println("Nombre,Puesto,Departamento");
                List<Trabajador> trabajadores = trabajadorRepository.findAllById(ids);
                for (Trabajador t : trabajadores) {
                    writer.printf("\"%s\",\"%s\",\"%s\"%n",
                            t.getNombre(), t.getPuesto(), t.getDepartamento());
                }
                break;

            default:
                writer.println("Tipo no reconocido.");
        }

        writer.flush();
        writer.close();
    }

    @PostMapping("/borrarFiltros")
    public String borrarFiltros(Model model, HttpSession session, @RequestParam Integer tipo) {
        UsuarioEntity usuario = (UsuarioEntity) session.getAttribute("user");
        if (usuario == null || usuario.getTipoUsuario().getId() != 5) {
            return "redirect:/login/";
        }

        // Eliminar filtros y orden según el tipo
        switch (tipo) {
            case 1:
                session.removeAttribute("filtrosPelicula");
                break;
            case 2:
                session.removeAttribute("filtrosReview");
                break;
            case 3:
                session.removeAttribute("filtrosActores");
                break;
            case 4:
                session.removeAttribute("filtrosUsuarios");
                break;
            case 5:
                session.removeAttribute("filtrosTrabajadores");
                break;
        }
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
        model.addAttribute("buscador", tipo);

        return "analista";
    }


    @PostMapping("/elegirBuscadorDePeliculas")
    public String elegirBuscadorDePeliculas(Model model, HttpSession session) {
        FiltrosPelicula filtros = (FiltrosPelicula) session.getAttribute("filtrosPelicula");
        if (filtros != null) {
            model.addAttribute("filtros", filtros);
        }
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