package com.login.service;

import com.login.model.Questions;
import com.login.repository.SupportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class SupportService {

    @Autowired
    private SupportRepository supportRepository;

    public List<Object> getQuestionsForUser(String username) {
        // Implementation remains the same
        return supportRepository.findQuestionsWithAnswers();

    }

    public List<Object> searchQuestionsByKeyword(String keyword) {
        return supportRepository.searchQuestionsByKeyword(keyword);
    }

    public void addQuestion(String username, String questionText) {
        Questions question = new Questions();
        question.setUsername(username);
        question.setQuestion_text(questionText);
        question.setTimestamp(LocalDateTime.now());
        supportRepository.save(question);
    }
}
