<jsp:include page="../header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation List</title>
    <!-- Bootstrap CSS for responsive design and table styling -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Optional: FontAwesome for the download icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

<div class="container mt-4">
    <h2 class="text-center mb-4">Reservation List</h2>

    <!-- Search Form with Filters -->
    <form method="get" action="/admin/view_reservations">
        <div class="form-row mb-3">
            <div class="col-md-3">
                <label for="firstName">First Name:</label>
                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter First Name" />
            </div>
            <div class="col-md-3">
                <label for="lastName">Last Name:</label>
                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter Last Name" />
            </div>
            <div class="col-md-3">
                <label for="transitLineName">Transit Line:</label>
                <input type="text" class="form-control" id="transitLineName" name="transitLineName" placeholder="Enter Transit Line" />
            </div>
            <div class="col-md-3">
                <button type="submit" class="btn btn-primary mt-4">Search</button>
            </div>
        </div>
    </form>

    <!-- Table for Displaying Reservations -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
            <tr>
                <th>Reservation No</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Origin Station</th>
                <th>Destination Station</th>
                <th>Ongoing Date</th>
                <th>Return Date</th>
                <th>Total Fare</th>
                <th>Round Trip</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="reservation" items="${reservations}">
                <tr>
                    <td>${reservation[0]}</td>
                    <td>${reservation[1]}</td>
                    <td>${reservation[2]}</td>
                    <td>${reservation[3]}</td>
                    <td>${reservation[4]}</td>
                    <td>${reservation[5]}</td>
                    <td>${reservation[6]}</td>
                    <td>${reservation[7]}</td>
                    <td>${reservation[8] ? 'Yes' : 'No'} </td>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Pagination Controls -->
    <div class="d-flex justify-content-center">
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link" href="?page=1" aria-label="First">
                    <span aria-hidden="true">&laquo;&laquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}">${i}</a>
                </li>
            </c:forEach>
            <li class="page-item">
                <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="?page=${totalPages}" aria-label="Last">
                    <span aria-hidden="true">&raquo;&raquo;</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- CSV Download Button -->
    <div class="text-center mt-4">
        <a href="/admin/reservations/download" class="btn btn-success">
            <i class="fas fa-download"></i> Download CSV
        </a>
    </div>
</div>

<!-- Bootstrap JS & jQuery for pagination controls -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
