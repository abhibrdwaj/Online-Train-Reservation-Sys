<jsp:include page="../header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Admin Dashboard</h1>

        <div class="row mt-4">
            <!-- Monthly Sales Report -->
            <div class="col-md-6 mb-4">
                <h3>Monthly Sales Report</h3>
                <canvas id="salesChart" width="400" height="200"></canvas>
            </div>

            <!-- Revenue by Transit Line -->
            <div class="col-md-6 mb-4">
                <h3>Revenue by Transit Line</h3>
                <canvas id="transitLineChart" width="400" height="200"></canvas>
            </div>
        </div>

        <div class="row">
            <!-- Revenue by Customer Name -->
            <div class="col-md-6 mb-4">
                <h3>Revenue by Customer Name</h3>
                <canvas id="customerRevenueChart" width="400" height="200"></canvas>
            </div>
        </div>
    </div>
    <script>
        // Fetch data from the server for the sales report
        fetch('/admin/dashboard/salesReport')
            .then(response => response.json())
            .then(data => {
                const ctx = document.getElementById('salesChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: data.labels, // Months
                        datasets: [{
                            label: 'Sales Revenue',
                            data: data.values, // Revenue
                            backgroundColor: 'rgba(54, 162, 235, 0.5)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('Error loading sales data:', error));

        // Fetch and render Revenue by Transit Line
        fetch('/admin/dashboard/revenueByTransitLine')
            .then(response => response.json())
            .then(data => {
                const ctx = document.getElementById('transitLineChart').getContext('2d');
                new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: data.labels, // Transit Line Names
                        datasets: [{
                            label: 'Revenue',
                            data: data.values, // Revenue
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.5)',
                                'rgba(54, 162, 235, 0.5)',
                                'rgba(255, 206, 86, 0.5)',
                                'rgba(75, 192, 192, 0.5)',
                                'rgba(153, 102, 255, 0.5)',
                                'rgba(255, 159, 64, 0.5)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    }
                });
            })
            .catch(error => console.error('Error loading transit line revenue:', error));

        // Fetch and render Revenue by Customer Name
        fetch('/admin/dashboard/revenueByCustomerName')
            .then(response => response.json())
            .then(data => {
                const ctx = document.getElementById('customerRevenueChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: data.labels, // Customer Names
                        datasets: [{
                            label: 'Revenue',
                            data: data.values, // Revenue
                            backgroundColor: 'rgba(153, 102, 255, 0.5)',
                            borderColor: 'rgba(153, 102, 255, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        indexAxis: 'y', // Horizontal Bar
                        scales: {
                            x: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('Error loading customer revenue:', error));
    </script>
</body>
</html>