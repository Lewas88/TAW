// Daniel Linares, Enrique Silveira y David Vilaseca

package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.*;
import es.uma.taw.proyectotaw.entity.*;
import es.uma.taw.proyectotaw.dao.PeliculaRepository;
import es.uma.taw.proyectotaw.dao.TrabajadorRepository;
import es.uma.taw.proyectotaw.entity.Actor;
import es.uma.taw.proyectotaw.entity.Pelicula;
import es.uma.taw.proyectotaw.entity.Trabajador;
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

@Controller
@RequestMapping("/trabajadores")
public class TrabajadorControlador {
    @Autowired
    protected TrabajadorRepository trabajadorRepository;
    @Autowired
    protected PeliculaRepository peliculaRepository;
    @Autowired
    protected TrabajadorPeliculaRepository trabajadorPeliculaRepository;
    @GetMapping("/")
    public String listarTrabajadores(Model model) {
        List<Trabajador> trabajadores = trabajadorRepository.findAll();
        model.addAttribute("trabajador", trabajadores);
        return "trabajadores";
    }

    @GetMapping("/ver")//Enrique, Daniel y David
    public String doVerTrabajador(@RequestParam(value = "id", defaultValue = "-1" )Integer id, HttpSession session, Model model) {
        Trabajador trabajador = this.trabajadorRepository.findById(id).orElse(new Trabajador());
        List<Pelicula> peliculasParticipadas = this.peliculaRepository.findPeliculasByTrabajadorId(id);
        UsuarioEntity user = (UsuarioEntity) session.getAttribute("user");
        model.addAttribute("user",user);
        model.addAttribute("trabajador", trabajador);
        model.addAttribute("peliculas", peliculasParticipadas);
        return "verTrabajador";
    }

    @GetMapping("/editar")
    public String doEditarTrabajor(@RequestParam(value = "id", defaultValue = "-1" )Integer id, Model model) {
        Trabajador trabajador = this.trabajadorRepository.findById(id).orElse(new Trabajador());
        model.addAttribute("trabajador", trabajador);
        return "editarTrabajador";
    }


    @GetMapping("/editarTrabajo")
    public String doEditarTrabajo(@RequestParam(value = "id", defaultValue = "-1" )Integer id, Model model) {
        Trabajador trabajador = this.trabajadorRepository.findById(id).orElse(new Trabajador());
        model.addAttribute("trabajador", trabajador);
        model.addAttribute("peliculas",peliculaRepository.findAll());
        model.addAttribute("peliculasTrabajadas",peliculaRepository.findPeliculasByActorId(id));
        model.addAttribute("trabajos",trabajadorPeliculaRepository.findByTrabajadorId(id));
        return "editarTrabajadorTrabajo";
    }

    @PostMapping("/guardar")
    public String doGuardarTrabajador(@RequestParam("id")Integer id,
                                      @RequestParam("nombre")String nombre,
                                      @RequestParam("puesto")String puesto,
                                      @RequestParam("departamento")String departamento,
                                      Model model) {
        Trabajador trabajador = this.trabajadorRepository.findById(id).orElse(new Trabajador());
        trabajador.setNombre(nombre);
        trabajador.setPuesto(puesto);
        trabajador.setDepartamento(departamento);
        this.trabajadorRepository.save(trabajador);
        return "redirect:/trabajadores/";
    }

    @GetMapping("/borrar")
    public String doBorrarTrabajador(@RequestParam("id")Integer id) {
        this.trabajadorRepository.deleteById(id);
        return "redirect:/trabajadores/";
    }

    @PostMapping("/guardarParticipaciones")
    public String guardarParticipaciones(
            @RequestParam("id") Integer trabajadorId,
            @RequestParam(value = "peliculasParticipadas", required = false) List<Integer> peliculasIds,
            @RequestParam(value = "trabajo", required = false) List<String> trabajos,
            Model model
    ) {
        Trabajador trabajador = this.trabajadorRepository.findById(trabajadorId).orElse(null);
        if (trabajador == null) {
            return "redirect:/trabajadores/";
        }

        // Elimina participaciones actuales
        List<TrabajadorPelicula> actuales = this.trabajadorPeliculaRepository.findByTrabajadorId(trabajadorId);
        this.trabajadorPeliculaRepository.deleteAll(actuales);

        // Añade nuevas participaciones
        if (peliculasIds != null) {
            for (int i = 0; i < peliculasIds.size(); i++) {
                Integer peliculaId = peliculasIds.get(i);
                Pelicula pelicula = this.peliculaRepository.findById(peliculaId).orElse(null);
                if (pelicula != null) {
                    String trabajo = (trabajos != null && trabajos.size() > i) ? trabajos.get(i) : "";

                    // Crear y asignar el ID compuesto
                    TrabajadorPeliculaId tpid = new TrabajadorPeliculaId();
                    tpid.setTrabajadorId(trabajadorId);
                    tpid.setPeliculaId(peliculaId);

                    TrabajadorPelicula tp = new TrabajadorPelicula();
                    tp.setId(tpid); // Asigna el ID compuesto
                    tp.setTrabajador(trabajador);
                    tp.setPelicula(pelicula);
                    tp.setTipoTrabajo(trabajo);
                    this.trabajadorPeliculaRepository.save(tp);
                }
            }
        }

        return "redirect:/trabajadores/ver?id=" + trabajadorId;
    }
}
