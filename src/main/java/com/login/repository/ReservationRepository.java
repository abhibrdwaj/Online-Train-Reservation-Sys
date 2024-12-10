package com.login.repository;


import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.login.model.Reservations;

@Repository
public interface ReservationRepository extends JpaRepository<Reservations,Long>{

    @Query(value = "SELECT * FROM Reservations r WHERE r.reservation_date = :reservationDate AND " +
                   "(r.origin_station_id, r.destination_station_id) IN (" +
                   "SELECT t.origin_station_id, t.destination_station_id FROM TransitLines t WHERE t.name = :transitLineName)", 
           nativeQuery = true)
    List<Reservations> findReservationsWithDateAndTransitLine(Date reservationDate, String transitLineName);


    
}
