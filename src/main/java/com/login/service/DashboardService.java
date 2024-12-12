package com.login.service;

import com.login.repository.AnalyticsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DashboardService {

    @Autowired
    private AnalyticsRepository analyticsRepositoryRepository;

    public Map<String, Object> getMonthlySalesReport() {
        List<Object> results = analyticsRepositoryRepository.findMonthlySales();
        return processChartData(results);
    }

    public Map<String, Object> getRevenueByTransitLine() {
        List<Object> results = analyticsRepositoryRepository.findRevenueByTransitLine();
        return processChartData(results);
    }

    public Map<String, Object> getRevenueByCustomerName() {
        List<Object> results = analyticsRepositoryRepository.findRevenueByCustomerName();
        return processChartData(results);
    }

    public Map<String, Object> getActiveTransitLines() {
        List<Object> results = analyticsRepositoryRepository.findTopActiveTransitLines();
        return processChartData(results);
    }

    public Map<String, Object> getBestCustomer() {
        Object[] result = (Object[]) analyticsRepositoryRepository.findBestCustomer();
        Map<String, Object> response = new HashMap<>();
        if (result != null) {
            response.put("name", result[0] + " " + result[1]); // Full Name
            response.put("revenue", ((Number) result[2]).doubleValue()); // Total Revenue
        } else {
            response.put("name", "N/A");
            response.put("revenue", 0);
        }
        return response;
    }

    private Map<String, Object> processChartData(List<Object> results) {
        Map<String, Object> chartData = new HashMap<>();
        List<String> labels = new ArrayList<>();
        List<Double> values = new ArrayList<>();

        for (Object result : results) {
            Object[] row = (Object[]) result;
            labels.add((String) row[0]); // First column (Month/TransitLine/Customer)
            values.add(((Number) row[1]).doubleValue()); // Second column (Revenue/Sales)
        }

        chartData.put("labels", labels);
        chartData.put("values", values);

        return chartData;
    }
}
