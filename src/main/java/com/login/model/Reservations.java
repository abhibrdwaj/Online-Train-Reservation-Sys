package com.login.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="Reservations")
public class Reservations {

    @Id
    @Column(name = "reservation_no")
    private int reservationNo;
    @Column(name = "customer")
    private String customer;
    @Column(name = "reservation_date")
    private LocalDate reservationDate;
    @Column(name = "origin_station_id")
    private int originStationId;
    @Column(name = "destination_station_id")
    private int destinationStationId;
    @Column(name = "schedule_id")
    private int scheduleId;
    @Column(name = "departure_datetime")
    private LocalDateTime departureDateTime;
    @Column(name = "total_fare")
    private long totalFare;
    @Column(name = "is_round_trip")
    private boolean roundTrip;

    public int getReservationNo() {
        return this.reservationNo;
    }

    public void setReservationNo(int reservationNo) {
        this.reservationNo = reservationNo;
    }

    public String getCustomer() {
        return this.customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public LocalDate getReservationDate() {
        return this.reservationDate;
    }

    public void setReservationDate(LocalDate reservationDate) {
        this.reservationDate = reservationDate;
    }

    public int getOriginStationId() {
        return this.originStationId;
    }

    public void setOrigin_station_id(int originStationId) {
        this.originStationId = originStationId;
    }

    public int getDestinationStationId() {
        return this.destinationStationId;
    }

    public void setDestination_station_id(int destinationStationId) {
        this.destinationStationId = destinationStationId;
    }

    public int getScheduleId() {
        return this.scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public LocalDateTime getDepartureDateTime() {
        return this.departureDateTime;
    }

    public void setDepartureDateTime(LocalDateTime departureDateTime) {
        this.departureDateTime = departureDateTime;
    }

    public long getTotalFare() {
        return this.totalFare;
    }

    public void setTotalFare(long totalFare) {
        this.totalFare = totalFare;
    }

    public boolean getRoundTrip() {
        return this.roundTrip;
    }

    public void setRoundTrip(boolean roundTrip) {
        this.roundTrip = roundTrip;
    }

}
