package com.login.controller;

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
    public String showWelcomePage(ModelMap model, @RequestParam String name, @RequestParam String password){
 
        User user = service.authenticateUser(name, password);
 
        if (user == null) {
            model.addAttribute("error", "Invalid Credentials");
            return "login";
        }
 
        model.addAttribute("user", user);
 
        return "make_reservation";
    }
     
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String showLogoutPage(ModelMap model){
        return "login";
    }
}
