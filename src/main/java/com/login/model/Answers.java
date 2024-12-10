package com.login.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Answers")
public class Answers {

    @Id
    @Column(name = "answer_id")
    private int answer_id;
    @Column(name = "question_id")
    private int question_id;
    @Column(name = "employee_id")
    private int employee_id;
    @Column(name = "answer_text")
    private String answer_text;
    @Column(name = "timestamp")
    private LocalDateTime timestamp;

    public int getAnswer_id() {
        return this.answer_id;
    }

    public void setAnswer_id(int answer_id) {
        this.answer_id = answer_id;
    }

    public int getQuestion_id() {
        return this.question_id;
    }

    public void setQuestion_id(int question_id) {
        this.question_id = question_id;
    }

    public int getEmployee_id() {
        return this.employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public String getAnswer_text() {
        return this.answer_text;
    }

    public void setAnswer_text(String answerText) {
        this.answer_text = answerText;
    }

    public LocalDateTime getTimestamp() {
        return this.timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }
    
}
