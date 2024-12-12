package com.login.repository;


import java.util.Date;
import java.util.List;

import com.login.model.Reservations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationRepository extends JpaRepository<Reservations,Long> {

    @Query(value = "SELECT * FROM Reservations r WHERE r.reservation_date = :reservationDate AND " +
                   "(r.origin_station_id, r.destination_station_id) IN (" +
                   "SELECT t.origin_station_id, t.destination_station_id FROM TransitLines t WHERE t.name = :transitLineName)", 
           nativeQuery = true)
    List<Reservations> findReservationsWithDateAndTransitLine(Date reservationDate, String transitLineName);

    //boolean existsByScheduleId(int scheduleId);


    


    @Query(value = """
             SELECT
                 r.reservation_no AS "reservation_no",
                 u.first_name AS "first_name",
                 u.last_name AS "last_name",
                 os.station_name AS "origin",
                 ds.station_name AS "destination",
                 r.ongoing_date AS "travel_date",
                 r.return_date AS "return_date",
                 r.total_fare AS "total_fare",
                 r.is_round_trip AS "round_trip"
             FROM
                 Reservations r
                     JOIN
                 Stations os ON r.origin_station_id = os.station_id
                     JOIN
                 Stations ds ON r.destination_station_id = ds.station_id
                     JOIN
                 Users u ON r.customer = u.username
                     WHERE
                             u.first_name = :firstName
                         AND
                             u.last_name = :lastName
            """, nativeQuery = true)
    Page<Object> findByUserName(String firstName, String lastName, Pageable pageable);

    @Query(value = """
            SELECT
              r.reservation_no AS "reservation_no",
              u.first_name AS "first_name",
              u.last_name AS "last_name",
              os.station_name AS "origin",
              ds.station_name AS "destination",
              r.ongoing_date AS "travel_date",
              r.return_date AS "return_date",
              r.total_fare AS "total_fare",
              r.is_round_trip AS "round_trip"
          FROM
              Reservations r
              JOIN
             Stations os ON r.origin_station_id = os.station_id
              JOIN
            Stations ds ON r.destination_station_id = ds.station_id
              JOIN
            Schedules s ON r.ongoing_schedule_id = s.schedule_id
              JOIN
            Users u ON r.customer = u.username
              JOIN
            Trains T ON S.train_id = T.train_id
            WHERE
              T.transit_line_name = :transitLineName
            """, nativeQuery = true)
    Page<Object> findByTransitLine(String transitLineName, Pageable pageable);

    // Find all reservations with pagination
    @Query(value = """
          SELECT
            r.reservation_no AS "reservation_no",
            u.first_name AS "first_name",
            u.last_name AS "last_name",
            os.station_name AS "origin",
            ds.station_name AS "destination",
            r.ongoing_date AS "travel_date",
            r.return_date AS "return_date",
            r.total_fare AS "total_fare",
            r.is_round_trip AS "round_trip"
        FROM
            Reservations r
        JOIN
            Stations os ON r.origin_station_id = os.station_id
        JOIN
            Stations ds ON r.destination_station_id = ds.station_id
        JOIN
            Users u ON r.customer = u.username
          """, nativeQuery = true)
    Page<Object> findAllPageable(Pageable pageable);

    @Query(value = """
        SELECT
            r.reservation_no AS "reservation_no",
            os.station_name AS "origin",
            ds.station_name AS "destination",
            r.ongoing_date AS "travel_date",
            r.return_date AS "return_date",
            r.total_fare AS "total_fare"
        FROM
            Reservations r
        JOIN
            Stations os ON r.origin_station_id = os.station_id
        JOIN
            Stations ds ON r.destination_station_id = ds.station_id
        WHERE
            r.customer = :customer
        ORDER BY
            r.ongoing_date DESC
        """, nativeQuery = true)
    List<Object> findByCustomers(String customer);

    void deleteByReservationNo(int reservationId);
}
