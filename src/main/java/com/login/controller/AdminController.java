package com.login.controller;

import com.login.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/dashboard")
    public String showDashboard(ModelMap model) {
        return "admin/dashboard";
    }

    @PostMapping("/addRep")
    public String addRep(@RequestParam String firstName,
                         @RequestParam String lastName,
                         @RequestParam String emailAddress,
                         @RequestParam String socialSecurityNumber,
                         @RequestParam String username) {
        adminService.addCustomerRep(lastName, firstName, username, emailAddress, socialSecurityNumber);
        return "redirect:/admin/manage_rep";
    }

    @GetMapping("/manage_rep")
    public String showManageRep(Model model) {
        // Fetch all customer representatives
        List<Map<String, Object>> reps = adminService.getAllCustomerReps();
        model.addAttribute("reps", reps);
        return "admin/manage_rep"; // JSP page
    }

    @PostMapping("/updateRep/{repId}")
    public String updateRep(
            @PathVariable("repId") String repId,
            @RequestParam("firstName") String firstName,
            @RequestParam("lastName") String lastName,
            @RequestParam("email") String email,
            @RequestParam("socialSecurityNumber") String socialSecurityNumber,
            Model model) {
        try {
            // Call the service to update the representative
            adminService.updateRep(repId, firstName, lastName, email, socialSecurityNumber);
            model.addAttribute("successMessage", "Representative updated successfully.");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating representative: " + e.getMessage());
        }
        return "redirect:/admin/manage_rep"; // Redirect back to the list of representatives
    }

    @DeleteMapping("/deleteRep/{repId}")
    public String deleteRep(@PathVariable String repId) {
        adminService.deleteCustomerRep(repId);
        return "redirect:/admin/manage_rep";
    }
}
