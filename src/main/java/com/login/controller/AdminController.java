package com.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("/dashboard")
    public String showDashboard(ModelMap model) {
        return "admin/dashboard";
    }

    @GetMapping("/manage_rep")
    public String showManageRep(ModelMap model) {
        return "admin/manage_rep";
    }
}
