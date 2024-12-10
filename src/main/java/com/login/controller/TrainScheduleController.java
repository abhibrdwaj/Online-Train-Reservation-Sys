package com.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import com.login.service.TrainScheduleService;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/train-schedules")
public class TrainScheduleController {

    @Autowired
    private TrainScheduleService trainScheduleService;

    @PostMapping("/search")
    public String searchSchedules(
            @RequestParam("origin") String origin,
            @RequestParam("destination") String destination,
            @RequestParam("tripType") String tripType,
            @RequestParam("travelDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate travelDate,
            @RequestParam(value = "returnDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate returnDate,
            @RequestParam("adults") int adults,
            @RequestParam("children") int children,
            @RequestParam("seniors") int seniors,
            Model model
    ) {
        // Validate input
        if (tripType.equals("round-trip") && (returnDate == null || returnDate.isBefore(travelDate))) {
            model.addAttribute("errorMessage", "Invalid return date for round-trip.");
            return "search-form"; // Return to the form with an error message
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Search train schedules for the given travel date and origin/destination
        List<Object> outgoingTrains = trainScheduleService.findSchedulesBetweenStations(origin, destination, travelDate.format(formatter));

        model.addAttribute("origin", origin);
        model.addAttribute("destination", destination);
        model.addAttribute("tripType", tripType);

        model.addAttribute("outgoingTrains", outgoingTrains);
        model.addAttribute("travelDate", travelDate);
        model.addAttribute("returnTrains", null);

        // Handle return trip schedules if it's a round trip
        if (tripType.equals("round-trip")) {
            List<Object> returnTrains = trainScheduleService.findSchedulesBetweenStations(destination, origin, returnDate.format(formatter));
            model.addAttribute("returnTrains", returnTrains);
            model.addAttribute("returnDate", returnDate);
        }

        // Passenger details
        model.addAttribute("adults", adults);
        model.addAttribute("children", children);
        model.addAttribute("seniors", seniors);
        return "search_results"; // JSP to display results
    }
}
