package com.login.controller;

import com.login.constants.Role;
import com.login.constants.TicketTypes;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.login.service.LoginService;
import com.login.model.User;

@Controller
public class LoginController {
	
	@Autowired
    LoginService service;
 
    @RequestMapping(value="/login", method = RequestMethod.GET)
    public String showLoginPage(ModelMap model){
        return "login";
    }
 
    @RequestMapping(value="/login", method = RequestMethod.POST)
    public String showWelcomePage(
            ModelMap model,
            @RequestParam String name,
            @RequestParam String password,
            HttpSession session) {
 
        User user = service.authenticateUser(name, password);
 
        if (user == null) {
            model.addAttribute("error", "Invalid Credentials");
            return "login";
        }

        // Redirect based on role
        Role role = user.getRole();
 
        model.addAttribute("user", user);
        model.addAttribute("ticketTypes", TicketTypes.values());

        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", role.toString());

        if (Role.ADMIN == role) {
            return "redirect:/admin/dashboard";
        } else {
            return "redirect:/user/home";
        }
    }
     
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String showLogoutPage(ModelMap model){
        return "login";
    }
}
