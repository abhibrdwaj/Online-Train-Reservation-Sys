package com.login.controller;

import com.login.service.ReservationService;
import com.login.service.SupportService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    private final ReservationService reservationService;
    private final SupportService supportService;

    public UserController(ReservationService reservationService, SupportService supportService) {
        this.reservationService = reservationService;
        this.supportService = supportService;
    }

    @GetMapping("/home")
    public String showHomePage(ModelMap model) {
        return "user/make_reservation";
    }

    @GetMapping("/my_bookings")
    public String viewBookings(HttpSession session, Model model) {
        String customer = session.getAttribute("username").toString();
        reservationService.getReservationsByCustomer(customer, model);
        return "user/my_bookings";
    }

    // Method to cancel a reservation
    @GetMapping("/cancelReservation/{reservationId}")
    public String cancelReservation(@PathVariable int reservationId, RedirectAttributes redirectAttributes) {
        try {
            // Cancel the reservation using the service
            reservationService.cancelReservation(reservationId);
            redirectAttributes.addFlashAttribute("message", "Reservation cancelled successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to cancel the reservation.");
        }
        // Redirect to the manage bookings page after cancellation
        return "redirect:/user/my_bookings";
    }

    @GetMapping("/support")
    public String showForum(Model model, HttpSession session,
                            @RequestParam(required = false) String keyword) {
        String username = session.getAttribute("username").toString();
        List<Object> questions;

        if (keyword != null && !keyword.isEmpty()) {
            questions = supportService.searchQuestionsByKeyword(keyword);
        } else {
            questions = supportService.getQuestionsForUser(username);
        }

        model.addAttribute("questions", questions);
        model.addAttribute("keyword", keyword);
        return "user/support";
    }

    @PostMapping("/support/ask")
    public String askQuestion(@RequestParam String questionText, HttpSession session) {
        String username = session.getAttribute("username").toString();
        supportService.addQuestion(username, questionText);
        return "redirect:/user/support";
    }
}
