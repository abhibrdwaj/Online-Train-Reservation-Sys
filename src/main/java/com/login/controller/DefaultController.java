package com.login.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class DefaultController {

    @GetMapping
    public String redirectUser(HttpSession session) {
        // Redirect root URL (/) to /login
        if (session.getAttribute("username") != null) {
            return "redirect:/home";
        }
        return "redirect:/login";
    }

    @GetMapping("/home")
    public String redirectHome(HttpSession session) {
        String role = session.getAttribute("role").toString();
        if ("ADMIN".equalsIgnoreCase(role)) {
            return "redirect:/admin/dashboard";
        } else if ("USER".equalsIgnoreCase(role)) {
            return "redirect:/user/home";
        } else if ("CUSTOMER_REP".equalsIgnoreCase(role)) {
        return "redirect:/rep";
        } else {
            return "redirect:/login";
        }
    }
}