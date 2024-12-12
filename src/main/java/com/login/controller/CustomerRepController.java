package com.login.controller;

import java.text.ParseException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
//import java.util.Date;
import java.util.List;

import com.login.model.*;
import org.aspectj.weaver.patterns.TypePatternQuestions.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.login.service.CustomerRepService;

@Controller
public class CustomerRepController {
    
    @Autowired
    private CustomerRepService customerRepService;

    @GetMapping("/customerRep")
    public String customerRep() {
        return "customerRep"; 
    }

    @GetMapping("/view-schedules")
    public String viewSchedules() {
        return "schedules";
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

    @GetMapping("/{id}")
    public ResponseEntity<Schedules> getScheduleById(@PathVariable int id) {
        Schedules schedule = customerRepService.getScheduleById(id);
        return schedule != null ? ResponseEntity.ok(schedule) : ResponseEntity.notFound().build();
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<Schedules> updateSchedule(@PathVariable int id, @RequestBody Schedules schedule) {
        if (customerRepService.getScheduleById(id) == null) {
            return ResponseEntity.notFound().build();
        }
        schedule.setScheduleId(id);
        return ResponseEntity.ok(customerRepService.updateSchedule(schedule));
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteSchedule(@PathVariable int id) {
        if (customerRepService.getScheduleById(id) == null) {
            return ResponseEntity.notFound().build();
        }
        customerRepService.deleteSchedule(id);
        return ResponseEntity.noContent().build();
    }



    // @PostMapping("/delete-schedule/{id}")
    // public String deleteSchedule(@PathVariable Long id) {
    //     customerRepService.deleteSchedule(id);
    //     return "redirect:/edit-delete-schedules";
    // }

    @GetMapping("/stationschedules")
    @ResponseBody
    public ResponseEntity<List<Schedules>> getStationSchedules(@RequestParam("stationName") String stationName) {
        List<Schedules> schedules = customerRepService.getSchedulesForStations(stationName);
        return ResponseEntity.ok(schedules);
    }

    @GetMapping("/reservations")
    @ResponseBody
    public ResponseEntity<List<User>> searchReservations(@RequestParam String date, @RequestParam String transitLineName) throws ParseException {
         List<User> users = customerRepService.getReservationsWithDateAndLine(date, transitLineName);
         return ResponseEntity.ok(users);
    }

    // @GetMapping("/questions")
    // public String showQuestions(Model model) {
    //     List<Questions> questions = customerRepService.getAllQuestions();
    //     model.addAttribute("questions", questions);
    //     return "replyQuestions";
    // }


    @GetMapping("/questions")
    @ResponseBody
    public ResponseEntity<List<Questions>> showQuestions(){
        List<Questions> question = customerRepService.getAllQuestions();
        return ResponseEntity.ok(question);
    }

    // @PostMapping("/submitAnswer")
    // public String submitAnswer(@RequestParam int questionId, 
    //                             @RequestParam String answerText) throws ParseException {
    //     Answers answer = new Answers();
    //     answer.setQuestion_id(questionId);
    //     answer.setAnswer_text(answerText);
    //     //answer.setTimestamp(new Date());
    //     LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
    //     answer.setTimestamp(localDateTime);

    //     customerRepService.saveAnswer(answer);
    //     return "redirect:/replyQuestions";
// }

        @PostMapping("/submitAnswer")
        public ResponseEntity<Answers> submitAnswer(@RequestBody Answers answer) {
            Answers savedAnswer = customerRepService.saveAnswer(answer);
            return new ResponseEntity<>(savedAnswer, HttpStatus.CREATED);
    }

}
