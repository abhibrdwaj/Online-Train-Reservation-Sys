package com.login.repository;

import com.login.model.Reservations;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnalyticsRepository extends JpaRepository<Reservations, Long> {

    @Query(value = """
            SELECT MONTHNAME(reservation_date) AS month, SUM(total_fare) AS totalsales
            FROM Reservations
            GROUP BY MONTHNAME(reservation_date);
            """, nativeQuery = true)
    List<Object> findMonthlySales();

    @Query(value = """
            SELECT T.transit_line_name, SUM(R.total_fare) AS Revenue
            FROM Reservations R
            JOIN Schedules S ON R.schedule_id = S.schedule_id
            JOIN Trains T ON S.train_id = T.train_id
            GROUP BY T.transit_line_name
            """, nativeQuery = true)
    List<Object> findRevenueByTransitLine();

    @Query(value = """
            SELECT CONCAT(U.first_name, ' ', U.last_name) AS CustomerName, SUM(R.total_fare) AS Revenue 
            FROM Reservations R
            JOIN Users U ON R.customer = U.username
            GROUP BY U.username
            """, nativeQuery = true)
    List<Object> findRevenueByCustomerName();

    @Query(value = """
            SELECT T.transit_line_name, COUNT(*) AS ReservationsCount
            FROM Reservations R
            JOIN Schedules S ON R.schedule_id = S.schedule_id
            JOIN Trains T ON S.train_id = T.train_id
            GROUP BY T.transit_line_name
            ORDER BY ReservationsCount DESC
            LIMIT 5
            """, nativeQuery = true)
    List<Object> findTopActiveTransitLines();

    @Query(value = """
            SELECT U.first_name, U.last_name, SUM(R.total_fare) AS TotalRevenue
            FROM Reservations R
            JOIN Users U ON R.customer = U.username
            GROUP BY U.username
            ORDER BY TotalRevenue DESC
            LIMIT 1
            """, nativeQuery = true)
    Object findBestCustomer();
}
