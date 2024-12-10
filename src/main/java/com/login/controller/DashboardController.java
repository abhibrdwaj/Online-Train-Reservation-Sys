package com.login.controller;

import com.login.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("/admin/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping
    public String showDashboard(ModelMap model) {
        return "admin/dashboard";
    }

    @GetMapping("/salesReport")
    @ResponseBody
    public Map<String, Object> getSalesReport() {
        return dashboardService.getMonthlySalesReport();
    }

    @GetMapping("/revenueByTransitLine")
    @ResponseBody
    public Map<String, Object> revenueByTransitLine() {
        return dashboardService.getRevenueByTransitLine();
    }

    @GetMapping("/revenueByCustomerName")
    @ResponseBody
    public Map<String, Object> revenueByCustomerName() {
        return dashboardService.getRevenueByCustomerName();
    }

    @GetMapping("/activeTransitLines")
    @ResponseBody
    public Map<String, Object> getActiveTransitLines() {
        return dashboardService.getActiveTransitLines();
    }

    @GetMapping("/bestCustomer")
    @ResponseBody
    public Map<String, Object> getBestCustomer() {
        return dashboardService.getBestCustomer();
    }

}
