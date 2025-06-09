// Daniel Linares 100%

package es.uma.taw.proyectotaw.controller;

import es.uma.taw.proyectotaw.dao.TrabajadorRepository;
import es.uma.taw.proyectotaw.entity.Trabajador;
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
    @GetMapping("/")
    public String listarTrabajadores(Model model) {
        List<Trabajador> trabajadores = trabajadorRepository.findAll();
        model.addAttribute("trabajador", trabajadores);
        return "trabajadores";
    }

    @GetMapping("/editar")
    public String doEditarTrabajor(@RequestParam(value = "id", defaultValue = "-1" )Integer id, Model model) {
        Trabajador trabajador = this.trabajadorRepository.findById(id).orElse(new Trabajador());
        model.addAttribute("trabajador", trabajador);
        return "editarTrabajador";
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
}
