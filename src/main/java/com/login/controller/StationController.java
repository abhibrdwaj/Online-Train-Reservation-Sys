package com.login.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


import com.login.model.TravelForm;
import com.login.service.StationService;

@RestController
public class StationController {

    @Autowired
    StationService stationService;

     @RequestMapping(value="/station/names", method = RequestMethod.GET)
    public List<String> getAllStationNames(){
        return stationService.getAllStations();
    }

    @PostMapping("/searchResults")
    public List<String> processForm(@ModelAttribute TravelForm form) {
        List<String> formData = new ArrayList<>();
        formData.add("Origin: " + form.getOrigin());
        formData.add("Destination: " + form.getDestination());
        formData.add("Travel Date: " + form.getTravelDate());
        formData.add("Return Date: " + form.getReturnDate());
        formData.add("Round Trip: " + form.isRoundTrip());
        formData.add("Adults: " + form.getAdults());
        formData.add("Children: " + form.getChildren());
        formData.add("Seniors: " + form.getSeniors());
    
    return formData;
}
    
}
