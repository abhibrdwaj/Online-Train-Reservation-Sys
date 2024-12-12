package com.login.model;

import jakarta.persistence.*;
import java.time.LocalTime;

@Entity
@Table(name = "Schedules")
public class Schedules {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-increment for schedule_id
    private Integer scheduleId;

    @Column(nullable = false)
    private Integer trainId;

    @Column(nullable = false)
    private LocalTime departureTime;

    @Column(nullable = false)
    private LocalTime arrivalTime;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Direction direction;

    // Enum for Direction
    public enum Direction {
        Forward,
        Reverse
    }

    // Getters and Setters
    public Integer getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(Integer scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Integer getTrainId() {
        return trainId;
    }

    public void setTrainId(Integer trainId) {
        this.trainId = trainId;
    }

    public LocalTime getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(LocalTime departureTime) {
        this.departureTime = departureTime;
    }

    public LocalTime getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(LocalTime arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public Direction getDirection() {
        return direction;
    }

    public void setDirection(Direction direction) {
        this.direction = direction;
    }

    // Optional: toString for debugging
    @Override
    public String toString() {
        return "Schedule{" +
                "scheduleId=" + scheduleId +
                ", trainId=" + trainId +
                ", departureTime=" + departureTime +
                ", arrivalTime=" + arrivalTime +
                ", direction=" + direction +
                '}';
    }
}
