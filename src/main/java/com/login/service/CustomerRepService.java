package com.login.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.aspectj.weaver.patterns.TypePatternQuestions.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.login.model.Answers;
import com.login.model.Questions;
import com.login.model.Reservations;
import com.login.model.Schedules;
import com.login.repository.AnswerRepository;
import com.login.repository.CustomerRepRepository;
import com.login.repository.QuestionRepository;
import com.login.repository.ReservationRepository;

@Service
public class CustomerRepService {
    
    @Autowired
    private CustomerRepRepository customerRepRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private AnswerRepository answerRepository;

    public List<Schedules> getAllSchedules(){
        return customerRepRepository.findAll();
    }

    public void deleteSchedule(Long id){
        customerRepRepository.deleteById(id);
    }

    public List<Schedules> getSchedulesForStations(){
        return customerRepRepository.findSchedulesWithValidStations();
    }

    public List<Reservations> getReservationsWithDateAndLine(String reservationDate,String TransitLines) throws ParseException{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date reservation = sdf.parse(reservationDate);
        return reservationRepository.findReservationsWithDateAndTransitLine(reservation,TransitLines);
    }

    public List<Questions> getAllQuestions() {
        return questionRepository.findAll();
    }

    public void saveAnswer(Answers answer) {
        answerRepository.save(answer);
    }
}
