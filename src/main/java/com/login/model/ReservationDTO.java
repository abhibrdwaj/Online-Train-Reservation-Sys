package com.login.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class ReservationDTO {
    private int reservationNo;
    private String origin;
    private String destination;
    private LocalDate travelDate;
    private LocalDate returnDate;
    private BigDecimal totalFare;

    public ReservationDTO(int reservationNo, String origin, String destination, LocalDate travelDate, LocalDate returnDate, BigDecimal totalFare) {
        this.reservationNo = reservationNo;
        this.origin = origin;
        this.destination = destination;
        this.travelDate = travelDate;
        this.returnDate = returnDate;
        this.totalFare = totalFare;
    }

    // Getters and setters
    public int getReservationNo() { return reservationNo; }
    public String getOrigin() { return origin; }
    public String getDestination() { return destination; }
    public LocalDate getTravelDate() { return travelDate; }
    public LocalDate getReturnDate() { return returnDate; }
    public BigDecimal getTotalFare() { return totalFare; }
}
