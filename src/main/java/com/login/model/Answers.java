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
    @Column(name = "question_id")
    private int question_id;
    @Column(name = "username")
    private String username;
    @Column(name = "answer_text")
    private String answer_text;
    @Column(name = "timestamp")
    private LocalDateTime timestamp;

    public int getQuestion_id() {
        return this.question_id;
    }

    public void setQuestion_id(int question_id) {
        this.question_id = question_id;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
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
