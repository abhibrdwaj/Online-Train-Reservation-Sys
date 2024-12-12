package com.login.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import com.login.model.*;
import com.login.repository.*;
import org.aspectj.weaver.patterns.TypePatternQuestions.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerRepService {
    
    @Autowired
    private SchedulesRepository schedulesRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private AnswerRepository answerRepository;
    @Autowired
    private UserRepository userRepository;

    public List<Schedules> getAllSchedules(){
        return schedulesRepository.findAll();
    }

    public Schedules getScheduleById(int id) {
        return schedulesRepository.findById(id).orElse(null);
    }

    public Schedules updateSchedule(Schedules schedule) {
        return schedulesRepository.save(schedule);
    }

    public void deleteSchedule(int id) {
        schedulesRepository.deleteById(id);
    }

    // public boolean deleteSchedule(int schedule_id) {
    //     // Check if there are any reservations for this schedule
    //     if (reservationRepository.existsByScheduleId(schedule_id)) {
    //         return false; // Cannot delete due to existing reservations
    //     }
        
    //     schedulesRepository.deleteById(scheduleId);
    //     return true;
    // }

    public List<Schedules> getSchedulesForStations(String keyword){
        return schedulesRepository.findSchedulesWithValidStations(keyword);
    }

    public List<User> getReservationsWithDateAndLine(String reservationDate, String TransitLines) throws ParseException{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date reservation = sdf.parse(reservationDate);
        return userRepository.findReservationsWithDateAndTransitLine(reservation,TransitLines);
    }

    public List<Questions> getAllQuestions() {
        return questionRepository.findUnansweredQuestions();
    }

    public Answers saveAnswer(Answers answer) {
        answer.setTimestamp(LocalDateTime.now());
        return answerRepository.save(answer);
    }
}
