package com.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DefaultController {

    @RequestMapping("/")
    public String redirectToLogin() {
        // Redirect root URL (/) to /login
        return "redirect:/login";
    }
}