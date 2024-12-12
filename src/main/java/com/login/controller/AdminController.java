package com.login.controller;

import com.login.model.Reservations;
import com.login.service.AdminService;
import com.login.service.ReservationService;
import com.opencsv.CSVWriter;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private ReservationService reservationService;

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

    @PostMapping("/updateRep")
    public String updateRep(
            @RequestBody Map<String, String> payload,
            Model model) {
        try {
            // Extract data from the payload
            String repId = payload.get("repId");
            String firstName = payload.get("firstName");
            String lastName = payload.get("lastName");
            String emailAddress = payload.get("emailAddress");
            String socialSecurityNumber = payload.get("socialSecurityNumber");

            // Call the service to update the representative
            adminService.updateRep(repId, firstName, lastName, emailAddress, socialSecurityNumber);
            model.addAttribute("successMessage", "Representative updated successfully.");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating representative: " + e.getMessage());
        }
        return "redirect:/admin/manage_rep"; // Redirect back to the list of representatives
    }

    @GetMapping("/deleteRep/{repId}")
    public String deleteRep(@PathVariable String repId) {
        adminService.deleteCustomerRep(repId);
        return "redirect:/admin/manage_rep";
    }

    @GetMapping("/view_reservations")
    public String getReservations(@RequestParam(required = false) String firstName,
                                  @RequestParam(required = false) String lastName,
                                  @RequestParam(required = false) String transitLineName,
                                  @RequestParam(defaultValue = "1") int page,
                                  Model model) {
        int pageSize = 10;
        Page<Object> reservations;
        long totalReservations;

        if (firstName != null && !firstName.isEmpty() && lastName != null && !lastName.isEmpty()) {
            reservations = reservationService.findByCustomerName(firstName, lastName, page, pageSize);
        } else if (transitLineName != null && !transitLineName.isEmpty()) {
            reservations = reservationService.findByTransitLine(transitLineName, page, pageSize);
        } else {
            reservations = reservationService.getAllReservationsPageable(page, pageSize);
        }

        totalReservations = reservations.getTotalElements();

        int totalPages = (int) Math.ceil((double) totalReservations / pageSize);

        model.addAttribute("reservations", reservations.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "admin/view_reservations";
    }

    @GetMapping("/reservations/download")
    public void downloadCSV(HttpServletResponse response) throws IOException {
        List<Reservations> reservations = reservationService.getAllReservations();

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=reservations.csv");

        try (CSVWriter writer = new CSVWriter(response.getWriter())) {
            String[] header = {"Reservation No", "Customer", "Reservation Date", "Origin Station", "Destination Station", "Total Fare", "Round Trip"};
            writer.writeNext(header);
            for (Reservations reservation : reservations) {
                String[] data = {
                        String.valueOf(reservation.getReservationNo()),
                        reservation.getCustomer(),
                        reservation.getReservationDate().toString(),
                        String.valueOf(reservation.getOriginStationId()),
                        String.valueOf(reservation.getDestinationStationId()),
                        String.valueOf(reservation.getTotalFare()),
                        reservation.isRoundTrip() ? "Yes" : "No"
                };
                writer.writeNext(data);
            }
        }
    }

}
