package com.login.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.login.model.Questions;

@Repository
public interface QuestionRepository extends JpaRepository<Questions,Integer>{

    List<Questions> findAll();
    
}
