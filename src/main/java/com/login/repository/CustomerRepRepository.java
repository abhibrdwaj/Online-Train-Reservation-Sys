package com.login.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.login.model.Schedules;

@Repository
public interface CustomerRepRepository extends JpaRepository<Schedules,Long>{

    @Query(value = "SELECT * FROM Schedules WHERE train_id IN " +
                   "(SELECT train_id FROM Trains WHERE transit_line_name IN " +
                   "(SELECT name FROM TransitLines WHERE origin_station_id IN " +
                   "(SELECT station_id FROM Stations) AND destination_station_id IN " +
                   "(SELECT station_id FROM Stations)))", nativeQuery = true)
    List<Schedules> findSchedulesWithValidStations();

    
    
}
