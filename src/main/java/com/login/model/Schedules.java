package com.login.model;

import jakarta.persistence.*;

import java.time.Duration;
import java.time.LocalDateTime;

@Entity
@Table(name = "schedules")
public class Schedules {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int scheduleId;

    @Column(name = "train_id", nullable = false)
    private int trainId;

    @Column(name = "departure_datetime", nullable = false)
    private LocalDateTime departureDatetime;

    @Column(name = "arrival_datetime", nullable = false)
    private LocalDateTime arrivalDatetime;

    @Column(name = "travel_time", nullable = false)
    private Duration travelTime;

    // Getters, Setters, and any additional methods
}