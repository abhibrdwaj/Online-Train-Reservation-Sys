package com.login.service;

import com.login.model.ReservationDTO;
import com.login.model.Reservations;
import com.login.repository.ReservationRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    // Find by customer name
    public Page<Reservations> findByCustomerName(String firstName, String lastName, int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);  // Page is 0-indexed
        return reservationRepository.findByUserName(firstName, lastName, pageable);
    }

    // Get paginated reservations based on transit line name
    public Page<Reservations> findByTransitLine(String transitLineName, int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);  // Page is 0-indexed
        return reservationRepository.findByTransitLine(transitLineName, pageable);
    }

    // Get all reservations with pagination
    public Page<Reservations> getAllReservationsPageable(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);  // Page is 0-indexed
        return reservationRepository.findAllPageable(pageable);
    }

    // Get all reservations wo pagination
    public List<Reservations> getAllReservations() {
        return reservationRepository.findAll();
    }

    public void saveReservation(Reservations reservation) {
        reservationRepository.save(reservation);
    }

    // Fetch all reservations for a specific customer and split them by OngoingDate
    public void getReservationsByCustomer(String username, Model model) {
        // Get all reservations
        List<Object> allReservations = reservationRepository.findByCustomers(username);

        // Get today's date for comparison
        LocalDate today = LocalDate.now();

        // Split the reservations into current and past
        List<ReservationDTO> currentReservations = new ArrayList<>();
        List<ReservationDTO> pastReservations = new ArrayList<>();

        for (Object result : allReservations) {
            Object[] reservation = (Object[]) result;
            int reservationNo = (int) reservation[0];
            String origin = (String) reservation[1];
            String destination = (String) reservation[2];
            LocalDate travelDate = ((java.sql.Date) reservation[3]).toLocalDate();
            LocalDate returnDate = (reservation[4] != null) ? ((java.sql.Date) reservation[4]).toLocalDate() : null;
            BigDecimal totalFare = (BigDecimal) reservation[5];

            // Create a DTO for reservation
            ReservationDTO reservationDTO = new ReservationDTO(reservationNo, origin, destination, travelDate, returnDate, totalFare);

            if (travelDate.isAfter(today) || travelDate.isEqual(today)) {
                currentReservations.add(reservationDTO);
            } else {
                pastReservations.add(reservationDTO);
            }
        }

        // Add them to the model
        model.addAttribute("currentReservations", currentReservations);
        model.addAttribute("pastReservations", pastReservations);
    }


    // Method to delete a reservation
    @Transactional
    public void cancelReservation(int reservationId) {
        reservationRepository.deleteByReservationNo(reservationId);
    }
}
