package com.login.service;

import com.login.model.Reservations;
import com.login.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
