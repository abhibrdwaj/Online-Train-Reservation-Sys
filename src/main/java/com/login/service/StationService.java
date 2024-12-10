package com.login.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.login.repository.StationRepository;

@Service
public class StationService {

    @Autowired
    private StationRepository stationRepository;

    public List<String> getAllStations(){
        return stationRepository.findAllByOrderByNameAsc();
    }
    
}
