package com.login.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Questions")
public class Questions {

    @Id
    @Column(name = "question_id")
    private int question_id;
    @Column(name = "customer_id")
    private int customer_id;
    @Column(name = "question_text")
    private int question_text;
    @Column(name = "timestamp")
    private LocalDateTime timestamp;

    public int getQuestion_id() {
        return this.question_id;
    }

    public void setQuestion_id(int question_id) {
        this.question_id = question_id;
    }

    public int getCustomer_id() {
        return this.customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getQuestion_text() {
        return this.question_text;
    }

    public void setQuestion_text(int question_text) {
        this.question_text = question_text;
    }

    public LocalDateTime getTimestamp() {
        return this.timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }
    
}
