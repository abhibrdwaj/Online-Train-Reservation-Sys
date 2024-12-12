package com.login.repository;

import java.util.List;

import org.aspectj.weaver.patterns.TypePatternQuestions.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
//import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.login.model.Questions;

@Repository
public interface QuestionRepository extends JpaRepository<Questions,Integer>{

    // @SuppressWarnings("null")
    // @Query(value = "SELECT q.question_id, q.question_text FROM Questions q", nativeQuery = true)
    // List<Questions> findAll();

    // @Query(value = "SELECT q.question_id, q.question_text FROM Questions q", nativeQuery = true)
    // List<Questions> findQuestion();

    @Query(value = "SELECT * FROM Questions q WHERE q.question_id NOT IN (SELECT a.question_id FROM Answers a)", nativeQuery = true)
    List<Questions> findUnansweredQuestions();

    
}
