package com.login.model;

import jakarta.persistence.*;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "Reservations")
public class Reservations {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reservation_no")
    private int reservationNo;

    @Column(name = "customer", nullable = false)
    private String customer;

    @Column(name = "reservation_date", nullable = false)
    private LocalDate reservationDate;

    @Column(name = "ongoing_date", nullable = false)
    private LocalDate ongoingDate;

    @Column(name = "return_date")
    private LocalDate returnDate;

    @Column(name = "origin_station_id")
    private int originStationId;

    @Column(name = "destination_station_id")
    private int destinationStationId;

    @Column(name = "ongoing_schedule_id")
    private int ongoingScheduleId;

    @Column(name = "return_schedule_id")
    private Integer returnScheduleId; // Make it Integer for nullable values

    @Column(name = "total_fare", nullable = false)
    private BigDecimal totalFare;

    @Column(name = "is_round_trip")
    private boolean isRoundTrip;

    // Getters and Setters

    public int getReservationNo() {
        return reservationNo;
    }

    public void setReservationNo(int reservationNo) {
        this.reservationNo = reservationNo;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public LocalDate getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(LocalDate reservationDate) {
        this.reservationDate = reservationDate;
    }

    public LocalDate getOngoingDate() {
        return ongoingDate;
    }

    public void setOngoingDate(LocalDate ongoingDate) {
        this.ongoingDate = ongoingDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public int getOriginStationId() {
        return originStationId;
    }

    public void setOriginStationId(int originStationId) {
        this.originStationId = originStationId;
    }

    public int getDestinationStationId() {
        return destinationStationId;
    }

    public void setDestinationStationId(int destinationStationId) {
        this.destinationStationId = destinationStationId;
    }

    public int getOngoingScheduleId() {
        return ongoingScheduleId;
    }

    public void setOngoingScheduleId(int ongoingScheduleId) {
        this.ongoingScheduleId = ongoingScheduleId;
    }

    public Integer getReturnScheduleId() {
        return returnScheduleId;
    }

    public void setReturnScheduleId(Integer returnScheduleId) {
        this.returnScheduleId = returnScheduleId;
    }

    public BigDecimal getTotalFare() {
        return totalFare;
    }

    public void setTotalFare(BigDecimal totalFare) {
        this.totalFare = totalFare;
    }

    public boolean isRoundTrip() {
        return isRoundTrip;
    }

    public void setRoundTrip(boolean roundTrip) {
        isRoundTrip = roundTrip;
    }
}
