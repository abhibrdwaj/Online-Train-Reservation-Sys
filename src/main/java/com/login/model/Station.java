package com.login.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "stations")
public class Station {
    @Id
    @Column(name = "station_id")
    private int station_id;
    @Column(name = "station_name", length = 100)
	private String station_name;
    @Column(name = "city", length = 100)
	private String city;
    @Column(name = "state", length = 100)
	private String state;
}
