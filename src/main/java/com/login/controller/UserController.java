package com.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

    @GetMapping("/home")
    public String showHomePage(ModelMap model) {
        return "user/make_reservation";
    }

    @GetMapping("/my_bookings")
    public String showMyBookings(ModelMap model) {
        return "user/my_bookings";
    }
}
