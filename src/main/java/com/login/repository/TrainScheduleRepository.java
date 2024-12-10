package com.login.repository;

import com.login.model.Schedules;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrainScheduleRepository extends JpaRepository<Schedules, Integer> {

    @Query(value = """
       SELECT
           s.schedule_id AS scheduleId,
           s.train_id AS trainId,
           TIME(ts1.departure_datetime) AS departureTime,
           TIME(ts2.arrival_datetime) AS arrivalTime,
           ABS(TIMESTAMPDIFF(MINUTE, ts1.departure_datetime, ts2.arrival_datetime)) AS duration,
           t.name AS transitLine,
       
           GROUP_CONCAT(
               CASE
                   WHEN ts.station_id != :originStationId AND ts.station_id != :destinationStationId THEN st.station_name
                   ELSE NULL
                   END
               ORDER BY ts.stop_number ASC
           ) AS stops,
       
           (t.fare *
            (SELECT COUNT(*)
             FROM TrainStops ts3
             WHERE ts3.schedule_id = s.schedule_id
               AND ts3.stop_number BETWEEN
                 (SELECT ts1.stop_number FROM TrainStops ts1 WHERE ts1.station_id = :originStationId AND ts1.schedule_id = s.schedule_id)
                 AND
                 (SELECT ts2.stop_number FROM TrainStops ts2 WHERE ts2.station_id = :destinationStationId AND ts2.schedule_id = s.schedule_id))
               / t.no_of_stops) AS baseFare
       
       FROM Schedules s
                JOIN TrainStops ts1 ON s.schedule_id = ts1.schedule_id
                JOIN TrainStops ts2 ON s.schedule_id = ts2.schedule_id
                JOIN TrainStops ts ON s.schedule_id = ts.schedule_id
                JOIN Stations st ON ts.station_id = st.station_id
                JOIN Trains tr ON s.train_id = tr.train_id
                JOIN TransitLines t ON tr.transit_line_name = t.name
       WHERE ts1.station_id = :originStationId
         AND ts2.station_id = :destinationStationId
         AND ts1.stop_number < ts2.stop_number
       GROUP BY s.schedule_id
""", nativeQuery = true)
    List<Object> findSchedulesBetweenStations(@Param("originStationId") int originStationId,
                                                           @Param("destinationStationId") int destinationStationId);
}