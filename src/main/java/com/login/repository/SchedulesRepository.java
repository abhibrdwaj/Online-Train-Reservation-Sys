package com.login.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.login.model.Schedules;

@Repository
public interface SchedulesRepository extends JpaRepository<Schedules,Integer>{

    @Query(value = """
                SELECT DISTINCT s.*
                FROM Schedules s
                 JOIN Trains t ON s.train_id = t.train_id
                 JOIN TransitLines tl ON t.transit_line_name = tl.name
                 JOIN Stations st ON tl.origin_station_id = st.station_id OR tl.destination_station_id = st.station_id
                WHERE st.station_name = :keyword
""" , nativeQuery = true)
    List<Schedules> findSchedulesWithValidStations(String keyword);

    
    
}
