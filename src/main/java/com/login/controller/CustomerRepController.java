package com.login.controller;

import java.text.ParseException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
//import java.util.Date;
import java.util.List;

import org.aspectj.weaver.patterns.TypePatternQuestions.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.login.model.Answers;
import com.login.model.Questions;
import com.login.model.Reservations;
import com.login.model.Schedules;
import com.login.service.CustomerRepService;

@Controller
public class CustomerRepController {
    
    @Autowired
    private CustomerRepService customerRepService;

    @GetMapping("/customerRep")
    public String customerRep() {
        return "customerRep"; 
    }

    @GetMapping("/editDelete")
    public String editDelete() {
        return "editDelete";
    }

    @GetMapping("/replyQuestions")
    public String replyQuestions() {
        return "replyQuestions";
    }

    @GetMapping("/customerReservations")
    public String customerReservations() {
        return "customerReservations";
    }

    @GetMapping("/stationSchedules")
    public String stationSchedules() {
        return "stationSchedules";
    }

    @PostMapping("/endpage")
    public String endpage() {
        return "endpage";
    }

    //  @GetMapping("/schedules")
    // public String getSchedules(Model model) {
    //     List<Schedules> schedules = customerRepService.getAllSchedules();
    //     model.addAttribute("schedules", schedules);
    //     return "customerRep";
    //     //return customerRep;
    // }

    @GetMapping("/schedules")
    @ResponseBody
    public List<Schedules> getSchedules() {
        return customerRepService.getAllSchedules();
    }

    @PostMapping("/delete-schedule/{id}")
    public String deleteSchedule(@PathVariable Long id) {
        customerRepService.deleteSchedule(id);
        return "redirect:/edit-delete-schedules";
    }

    @GetMapping("/stationschedules")
    @ResponseBody
    public ResponseEntity<List<Schedules>> getStationSchedules() {
        List<Schedules> schedules = customerRepService.getSchedulesForStations();
        return ResponseEntity.ok(schedules);
    }

    @GetMapping("/reservations")
    @ResponseBody
    public ResponseEntity<List<Reservations>> searchReservations(@RequestParam String date, @RequestParam String transitLineName) throws ParseException {
         List<Reservations> reservation = customerRepService.getReservationsWithDateAndLine(date, transitLineName);
         return ResponseEntity.ok(reservation);
    }

    @GetMapping("/questions")
    public String showQuestions(Model model) {
        List<Questions> questions = customerRepService.getAllQuestions();
        model.addAttribute("questions", questions);
        return "replyQuestions";
    }

    @PostMapping("/submitAnswer")
    public String submitAnswer(@RequestParam int questionId, 
                                @RequestParam String answerText) throws ParseException {
        Answers answer = new Answers();
        answer.setQuestion_id(questionId);
        answer.setAnswer_text(answerText);
        //answer.setTimestamp(new Date());
        LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
        answer.setTimestamp(localDateTime);

        customerRepService.saveAnswer(answer);
        return "redirect:/replyQuestions";
    }
}
