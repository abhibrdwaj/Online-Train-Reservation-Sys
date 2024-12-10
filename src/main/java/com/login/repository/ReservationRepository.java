package com.login.repository;

import com.login.model.Reservations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservations, Long> {

    @Query(value = """
            SELECT R.*
            FROM Reservations R
            JOIN Users U ON R.customer = U.username
            WHERE U.first_name = :firstName
            AND U.last_name = :lastName
            """, nativeQuery = true)
    Page<Reservations> findByUserName(String firstName, String lastName, Pageable pageable);

    @Query(value = """
            SELECT R.*
            FROM Reservations R
            JOIN Schedules S ON R.schedule_id = S.schedule_id
            JOIN Trains T ON S.train_id = T.train_id
            WHERE T.transit_line_name = :transitLineName
            """, nativeQuery = true)
    Page<Reservations> findByTransitLine(String transitLineName, Pageable pageable);

    // Find all reservations with pagination
    @Query(value = """
          SELECT *
          FROM Reservations
          """, nativeQuery = true)
    Page<Reservations> findAllPageable(Pageable pageable);
}
