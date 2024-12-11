package com.login.service;

import com.login.model.Reservations;
import com.login.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.time.LocalDate;
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
        List<Reservations> allReservations = reservationRepository.findByCustomerOrderByOngoingDateDesc(username);

        // Get today's date for comparison
        LocalDate today = LocalDate.now();

        // Split the reservations into current and past
        List<Reservations> currentReservations = allReservations.stream()
                .filter(reservation -> reservation.getOngoingDate().isAfter(today) || reservation.getOngoingDate().isEqual(today))
                .collect(Collectors.toList());

        List<Reservations> pastReservations = allReservations.stream()
                .filter(reservation -> reservation.getOngoingDate().isBefore(today))
                .collect(Collectors.toList());

        // Add them to the model
        model.addAttribute("currentReservations", currentReservations);
        model.addAttribute("pastReservations", pastReservations);
    }

    // Method to delete a reservation
    public void cancelReservation(int reservationId) {
        reservationRepository.deleteByReservationNo(reservationId);
    }
}
