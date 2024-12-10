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
    private int reservation_no;
    @Column(name = "customer")
    private String customer;
    @Column(name = "reservation_date")
    private LocalDate reservation_date;
    @Column(name = "origin_station_id")
    private int origin_station_id;
    @Column(name = "destination_station_id")
    private int destination_station_id;
    @Column(name = "schedule_id")
    private int schedule_id;
    @Column(name = "departure_datetime")
    private LocalDateTime departure_datetime;
    @Column(name = "total_fare")
    private long total_fare;
    @Column(name = "is_round_trip")
    private boolean is_round_trip;

    public int getReservation_no() {
        return this.reservation_no;
    }

    public void setReservation_no(int reservation_no) {
        this.reservation_no = reservation_no;
    }

    public String getCustomer() {
        return this.customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public LocalDate getReservation_date() {
        return this.reservation_date;
    }

    public void setReservation_date(LocalDate reservation_date) {
        this.reservation_date = reservation_date;
    }

    public int getOrigin_station_id() {
        return this.origin_station_id;
    }

    public void setOrigin_station_id(int origin_station_id) {
        this.origin_station_id = origin_station_id;
    }

    public int getDestination_station_id() {
        return this.destination_station_id;
    }

    public void setDestination_station_id(int destination_station_id) {
        this.destination_station_id = destination_station_id;
    }

    public int getSchedule_id() {
        return this.schedule_id;
    }

    public void setSchedule_id(int schedule_id) {
        this.schedule_id = schedule_id;
    }

    public LocalDateTime getDeparture_datetime() {
        return this.departure_datetime;
    }

    public void setDeparture_datetime(LocalDateTime departure_datetime) {
        this.departure_datetime = departure_datetime;
    }

    public long getTotal_fare() {
        return this.total_fare;
    }

    public void setTotal_fare(long total_fare) {
        this.total_fare = total_fare;
    }

    public boolean isIs_round_trip() {
        return this.is_round_trip;
    }

    public void setIs_round_trip(boolean is_round_trip) {
        this.is_round_trip = is_round_trip;
    }

}
