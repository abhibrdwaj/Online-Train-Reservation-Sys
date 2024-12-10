package com.login.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="schedules")
public class Schedules {

    @Id
    @Column(name = "schedule_id")
    private int schedule_id;
    @Column(name = "train_id")
    private int train_id;
    @Column(name = "departure_datetime")
    private LocalDateTime departure_datetime;
    @Column(name = "arrival_datetime")
    private LocalDateTime arrival_datetime;
    @Column(name = "travel_time")
    private LocalTime travel_time;

    public int getSchedule_id() {
        return this.schedule_id;
    }

    public void setSchedule_id(int schedule_id) {
        this.schedule_id = schedule_id;
    }

    public int getTrain_id() {
        return this.train_id;
    }

    public void setTrain_id(int train_id) {
        this.train_id = train_id;
    }

    public LocalDateTime getDeparture_datetime() {
        return this.departure_datetime;
    }

    public void setDeparture_datetime(LocalDateTime departure_datetime) {
        this.departure_datetime = departure_datetime;
    }

    public LocalDateTime getArrival_datetime() {
        return this.arrival_datetime;
    }

    public void setArrival_datetime(LocalDateTime arrival_datetime) {
        this.arrival_datetime = arrival_datetime;
    }

    public LocalTime getTravel_time() {
        return this.travel_time;
    }

    public void setTravel_time(LocalTime travel_time) {
        this.travel_time = travel_time;
    }

    
}
