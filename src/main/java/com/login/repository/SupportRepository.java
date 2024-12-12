package com.login.repository;

import com.login.model.Questions;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SupportRepository extends JpaRepository<Questions, Long> {
    @Query(value = """
            SELECT q.*, a.username as answer_username, a.answer_text, a.timestamp as answer_timestamp 
                                  FROM Questions q LEFT JOIN Answers a ON q.question_id = a.question_id
                                  ORDER BY q.timestamp DESC
           """, nativeQuery = true)
    List<Object> findQuestionsWithAnswers();

    @Query(value = """
        SELECT q.*, a.username as answer_username, a.answer_text, a.timestamp as answer_timestamp
        FROM Questions q LEFT JOIN Answers a ON q.question_id = a.question_id
        WHERE LOWER(q.question_text) LIKE LOWER(CONCAT('%', :keyword, '%'))
        ORDER BY q.timestamp DESC

""", nativeQuery = true)
    List<Object> searchQuestionsByKeyword(String keyword);

}

