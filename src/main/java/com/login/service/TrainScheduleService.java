package com.login.service;

import com.login.repository.StationRepository;
import com.login.repository.TrainScheduleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class TrainScheduleService {

    @Autowired
    private TrainScheduleRepository trainScheduleRepository;

    @Autowired
    private StationRepository stationRepository;

    public List<Map<String, Object>> findSchedulesBetweenStations(String originStationName, String destinationStationName, Map<String, Integer> passengerCounts) {
        // Lookup station IDs
        Integer originStationId = stationRepository.findStationIdByStationName(originStationName);
        Integer destinationStationId = stationRepository.findStationIdByStationName(destinationStationName);

        if (originStationId == null || destinationStationId == null) {
            throw new IllegalArgumentException("Invalid station name provided.");
        }

        // Fetch schedules based on station IDs
        List<Object> results = trainScheduleRepository.findSchedulesBetweenStations(originStationId, destinationStationId);
        List<Map<String, Object>> scheduleDetails = new ArrayList<>();

        int adults = passengerCounts.getOrDefault("adults", 0);
        int children = passengerCounts.getOrDefault("children", 0);
        int disabled = passengerCounts.getOrDefault("disabled", 0);
        int seniors = passengerCounts.getOrDefault("seniors", 0);

        for (Object result : results) {
            Object[] row = (Object[]) result;
            Map<String, Object> schedule = new HashMap<>();
            schedule.put("scheduleId", row[0]);
            schedule.put("trainId", row[1]);
            schedule.put("departureTime", row[2]);
            schedule.put("arrivalTime", row[3]);
            schedule.put("travelTime", row[4]);
            schedule.put("transitLine", row[5]);
            if (row[6] != null) {
                schedule.put("stops", ((String) row[6]).split(",")); // Split stops into an array
            } else {
                schedule.put("stops", "0"); // Split stops into an array
            }

            double baseFare = ((BigDecimal) row[7]).doubleValue();

            double totalFare = 0.0;
            totalFare += adults * baseFare;            // Adults pay full fare
            totalFare += children * baseFare * 0.75;  // Children get a 25% discount
            totalFare += seniors * baseFare * 0.65;   // Seniors get a 35% discount
            totalFare += disabled * baseFare * 0.50; // Disabled get a 50% discount

            schedule.put("fare", Math.round(totalFare * 100.0) / 100.0); // Round to 2 decimal places
            scheduleDetails.add(schedule);
        }

        return scheduleDetails;
    }


    public void sortSchedules(List<Map<String, Object>> trains, String sortBy) {
        if (sortBy != null) {
            switch (sortBy) {
                case "departureTime":
                    trains.sort(Comparator.comparing(train -> {
                        java.sql.Time departureTime = (java.sql.Time) train.get("departureTime");
                        return departureTime.toLocalTime();
                    }));
                    break;
                case "arrivalTime":
                    trains.sort(Comparator.comparing(train -> {
                        java.sql.Time arrivalTime = (java.sql.Time) train.get("arrivalTime");
                        return arrivalTime.toLocalTime();
                    }));
                    break;
                case "fare":
                    trains.sort(Comparator.comparing(train -> (Double) train.get("fare")));
                    break;
                default:
                    // Handle default sorting if needed
                    break;
            }
        }
    }

}
