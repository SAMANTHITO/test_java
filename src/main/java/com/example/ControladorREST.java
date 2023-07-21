/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example;

import com.example.domain.Individuo;
import java.util.Arrays;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class ControladorREST {

    @GetMapping("/")
    public String comienzo(Model model) {
        String hola = "Hola mundo con Spring Boot";

        Individuo individuo = new Individuo();
        individuo.setNombre("Alfonso");
        individuo.setApellido("Vera");
        individuo.setTelefono("099999999");
        individuo.setCorreo("alfonso@gmail.com");
        individuo.setEdad("20");

        Individuo individuo2 = new Individuo();
        individuo2.setNombre("Julia");
        individuo2.setApellido("Vera");
        individuo2.setTelefono("0888888");
        individuo2.setCorreo("julia@gmail.com");
        individuo2.setEdad("40");

        //List<Individuo> individuos = new ArrayList();
        // individuos.add(individuo);
        //individuos.add(individuo2);
        
        List individuos = Arrays.asList(individuo, individuo2);
        
        log.info("Estoy ejecutando el controlador MVC");
        model.addAttribute("hola", hola);
        model.addAttribute("individuo", individuo);
        model.addAttribute("individuos",individuos);
        return "indice";
    }
}
