package com.login.model;

import java.time.LocalDate;

public class TravelForm {
    private String origin;
    private String destination;
    private LocalDate travelDate;
    private LocalDate returnDate;
    private boolean roundTrip;
    private int adults;
    private int children;
    private int seniors;

    public String getOrigin() {
        return this.origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getDestination() {
        return this.destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public LocalDate getTravelDate() {
        return this.travelDate;
    }

    public void setTravelDate(LocalDate travelDate) {
        this.travelDate = travelDate;
    }

    public LocalDate getReturnDate() {
        return this.returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public boolean isRoundTrip() {
        return this.roundTrip;
    }

    public void setRoundTrip(boolean roundTrip) {
        this.roundTrip = roundTrip;
    }

    public int getAdults() {
        return this.adults;
    }

    public void setAdults(int adults) {
        this.adults = adults;
    }

    public int getChildren() {
        return this.children;
    }

    public void setChildren(int children) {
        this.children = children;
    }

    public int getSeniors() {
        return this.seniors;
    }

    public void setSeniors(int seniors) {
        this.seniors = seniors;
    }
}