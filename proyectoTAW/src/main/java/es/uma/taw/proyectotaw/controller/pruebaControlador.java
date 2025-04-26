package es.uma.taw.proyectotaw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class pruebaControlador {
    @GetMapping("/prueba")
    public String prueba() {
        return "temp";
    }
}
