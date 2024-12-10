package com.login.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.login.model.Answers;

@Repository
public interface AnswerRepository extends JpaRepository<Answers,Integer>{
    
}
