package com.login.controller;

import com.login.service.ReservationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {

    private final ReservationService reservationService;

    public UserController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @GetMapping("/home")
    public String showHomePage(ModelMap model) {
        return "user/make_reservation";
    }

    @GetMapping("/my_bookings")
    public String showMyBookings(ModelMap model) {
        return "user/my_bookings";
    }

    @GetMapping("/my-bookings")
    public String viewBookings(HttpSession session, Model model) {
        String customer = session.getAttribute("username").toString();
        reservationService.getReservationsByCustomer(customer, model);
        return "user/my-bookings";
    }

    // Method to cancel a reservation
    @PostMapping("/cancelReservation/")
    public String cancelReservation(@RequestParam("reservationId") int reservationId, RedirectAttributes redirectAttributes) {
        try {
            // Cancel the reservation using the service
            reservationService.cancelReservation(reservationId);
            redirectAttributes.addFlashAttribute("message", "Reservation cancelled successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to cancel the reservation.");
        }
        // Redirect to the manage bookings page after cancellation
        return "redirect:/user/my-bookings";
    }
}
