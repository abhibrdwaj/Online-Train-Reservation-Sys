package com.login.repository;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.login.model.Reservations;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.login.model.User;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends CrudRepository<User, Long> {
    Optional<User> findByUsername(String username);

    @Query(value = "SELECT u.last_name AS lastName, " +
            "u.first_name AS firstName, " +
            "u.username AS username, " +
            "u.email_address AS emailAddress, " +
            "u.social_security_number AS socialSecurityNumber, " +
            "u.role AS role " +
            "FROM Users u WHERE u.role = :role",
            nativeQuery = true)
    List<Map<String, Object>> findAllByRole(@Param("role") String role);

    // Check if a username exists
    boolean existsByUsername(String username);

    // Delete a user by username
    void deleteByUsername(String username);

     @Query(value="""
             SELECT
                U.*
            FROM
                Reservations R
            JOIN
                Schedules S ON R.ongoing_schedule_id = S.schedule_id
            JOIN
                Trains T ON S.train_id = T.train_id
            JOIN
                Users U ON R.customer = U.username
            WHERE
                T.transit_line_name = :transitLineName
                AND R.reservation_date = :reservationDate
            """, nativeQuery = true)
     List<User> findReservationsWithDateAndTransitLine(Date reservationDate, String transitLineName);

}