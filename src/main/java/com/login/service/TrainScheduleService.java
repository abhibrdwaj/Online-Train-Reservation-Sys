package com.login.service;

import com.login.repository.StationRepository;
import com.login.repository.TrainScheduleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainScheduleService {

    @Autowired
    private TrainScheduleRepository trainScheduleRepository;

    @Autowired
    private StationRepository stationRepository;

    public List<Object> findSchedulesBetweenStations(String originStationName, String destinationStationName, String travelDate) {
        // Lookup station IDs
        Integer originStationId = stationRepository.findStationIdByStationName(originStationName);
        Integer destinationStationId = stationRepository.findStationIdByStationName(destinationStationName);

        if (originStationId == null || destinationStationId == null) {
            throw new IllegalArgumentException("Invalid station name provided.");
        }

        // Fetch schedules based on station IDs
        return trainScheduleRepository.findSchedulesBetweenStations(originStationId, destinationStationId);
    }
}
