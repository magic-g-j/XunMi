package com.tutulei.xunmi.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    String Hello(){
        return "Hello Spring boot";
    }
}
