package com.login.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.login.model.Station;
import org.springframework.data.repository.query.Param;

public interface StationRepository extends JpaRepository<Station, Long>{
    @Query(value = "SELECT s.station_name FROM Stations s", nativeQuery = true)
    List<String> findAllByOrderByNameAsc();

    @Query("SELECT s.stationId FROM Station s WHERE s.stationName = :stationName")
    Integer findStationIdByStationName(@Param("stationName") String stationName);

}
