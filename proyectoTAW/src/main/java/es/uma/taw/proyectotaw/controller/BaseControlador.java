package es.uma.taw.proyectotaw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BaseControlador {
    @GetMapping("/")
    public String doHome() {
        return "home";
    }
}
