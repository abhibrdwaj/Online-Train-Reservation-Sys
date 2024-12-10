package com.login.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "TrainStops")
public class TrainStops {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "station_id")
    private int stationId;

    @Column(name = "schedule_id")
    private int scheduleId;

    @Column(name = "stop_number")
    private int stopNumber;

    @Column(name = "departure_datetime")
    private LocalDateTime departureDatetime;

    @Column(name = "arrival_datetime")
    private LocalDateTime arrivalDatetime;

    // Getters and Setters
}
