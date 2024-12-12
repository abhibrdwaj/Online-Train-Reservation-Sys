package com.login.controller;

import com.login.model.Reservations;
import com.login.repository.StationRepository;
import com.login.service.ReservationService;
import com.login.service.StationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import com.login.service.TrainScheduleService;

import java.math.BigDecimal;
import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/train-schedules")
public class TrainScheduleController {

    @Autowired
    private TrainScheduleService trainScheduleService;
    @Autowired
    private StationService stationService;
    @Autowired
    private StationRepository stationRepository;
    @Autowired
    private ReservationService reservationService;

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
            @RequestParam("disabled") int disabled,
            @RequestParam(value = "sortBy", required = false) String sortBy,
            Model model,
            Sort sort) {
        // Validate input
        if (tripType.equals("round-trip") && (returnDate == null || returnDate.isBefore(travelDate))) {
            model.addAttribute("errorMessage", "Invalid return date for round-trip.");
            return "user/search_results"; // Return to the form with an error message
        }

        Map<String, Integer> passengerCounts = new HashMap<>();
        passengerCounts.put("adults", adults);
        passengerCounts.put("children", children);
        passengerCounts.put("disabled", disabled);
        passengerCounts.put("seniors", seniors);

        // Search train schedules for the given travel date and origin/destination
        List<Map<String, Object>> outgoingTrains = trainScheduleService.findSchedulesBetweenStations(origin, destination, passengerCounts);
        if (sortBy != null) {
            // Sort outgoing trains based on the criteria
            trainScheduleService.sortSchedules(outgoingTrains, sortBy);
            model.addAttribute("sortBy", sortBy);
        }

        model.addAttribute("outgoingTrains", outgoingTrains);
        model.addAttribute("travelDate", travelDate);
        model.addAttribute("returnTrains", null);

        // Handle return trip schedules if it's a round trip
        if (tripType.equals("round-trip")) {
            List<Map<String, Object>> returnTrains = trainScheduleService.findSchedulesBetweenStations(destination, origin, passengerCounts);
            if (sortBy != null) {
                // Sort return trains based on the criteria
                trainScheduleService.sortSchedules(returnTrains, sortBy);
            }
            model.addAttribute("returnTrains", returnTrains);
            model.addAttribute("returnDate", returnDate);
        }

        // Passenger details
        model.addAttribute("adults", adults);
        model.addAttribute("children", children);
        model.addAttribute("seniors", seniors);
        model.addAttribute("disabled", disabled);
        model.addAttribute("origin", origin);
        model.addAttribute("destination", destination);
        model.addAttribute("tripType", tripType);
        return "user/search_results"; // JSP to display results
    }


    @PostMapping("/confirm-booking")
    public String confirmReservation(@RequestParam("origin") String origin,
                                     @RequestParam("destination") String destination,
                                     @RequestParam("travelDate") String travelDate,
                                     @RequestParam(value = "returnDate", required = false) String returnDate,
                                     @RequestParam("tripType") String tripType,
                                     @RequestParam("outgoingSelection") int ongoingScheduleId,
                                     @RequestParam("selectedOutgoingFare") BigDecimal outgoingFare,
                                     @RequestParam(value = "selectedReturnFare", required = false) BigDecimal returnFare,
                                     @RequestParam(value = "returnSelection", required = false) Integer returnScheduleId,
                                     HttpSession session, Model model) {
        String customer = session.getAttribute("username").toString();

        Reservations reservation = new Reservations();
        reservation.setCustomer(customer);
        reservation.setOngoingDate(LocalDate.parse(travelDate));
        if (tripType.equals("round-trip")) {
            reservation.setReturnDate(returnDate != null ? LocalDate.parse(returnDate) : null);
            reservation.setRoundTrip(true);
        } else {
            reservation.setReturnDate(null);
            reservation.setRoundTrip(false);
        }

        int originStationId = stationRepository.findStationIdByStationName(origin);
        int destinationStationId = stationRepository.findStationIdByStationName(destination);

        BigDecimal totalFare = BigDecimal.valueOf(0);

        totalFare = outgoingFare;
        if (returnFare != null) {
            totalFare = totalFare.add(returnFare);
        }

        reservation.setOriginStationId(originStationId);
        reservation.setDestinationStationId(destinationStationId);
        reservation.setReservationDate(LocalDate.now());
        reservation.setOngoingScheduleId(ongoingScheduleId);
        reservation.setReturnScheduleId(returnScheduleId);
        reservation.setTotalFare(totalFare);
        reservation.setRoundTrip(tripType.equals("round-trip") ? true : false);

        // Save the reservation via the service layer
        reservationService.saveReservation(reservation);

        model.addAttribute("reservation", reservation);

        return "user/booking_confirmation";


    }
}
