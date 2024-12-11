<%@ include file="../header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Your Reservations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            margin: 20px auto;
            width: 80%;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .reservation-list {
            width: 100%;
            border-collapse: collapse;
        }

        .reservation-list th, .reservation-list td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .reservation-list th {
            background-color: #f2f2f2;
        }

        .actions button {
            margin: 0 5px;
        }

        .cancel-btn {
            background-color: #FF6347;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .cancel-btn:hover {
            background-color: #FF4500;
        }

        .message {
            text-align: center;
            margin-top: 30px;
        }

        .reservation-section {
            display: none;
        }

        .active {
            display: block;
        }
    </style>
</head>
<body>
<c:if test="${not empty message}">
    <div class="alert alert-success">
            ${message}
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">
            ${error}
    </div>
</c:if>

<div class="container">
    <div class="header">
        <h2>Your Reservations</h2>
        <label for="reservationType">Select Reservation Type:</label>
        <select id="reservationType" onchange="toggleReservationList()">
            <option value="current">Current Reservations</option>
            <option value="past">Past Reservations</option>
        </select>
    </div>

    <!-- Current Reservations -->
    <div id="currentReservations" class="reservation-section active">
        <h3>Current Reservations</h3>
        <table class="reservation-list">
            <thead>
            <tr>
                <th>Reservation Number</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>Travel Date</th>
                <th>Return Date</th>
                <th>Total Fare</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="reservation" items="${currentReservations}">
                <tr id="reservation-${reservation.reservationNo}">
                    <td>${reservation.reservationNo}</td>
                    <td>${reservation.originStationId}</td>
                    <td>${reservation.destinationStationId}</td>
                    <td>${reservation.ongoingDate}</td>
                    <td>${reservation.returnDate != null ? reservation.returnDate : "N/A"}</td>
                    <td>${reservation.totalFare}</td>
                    <td>
                        <c:choose>
                            <c:when test="${reservation.isCanceled == true}">
                                <span style="color: red;">Canceled</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: green;">Active</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <form action="/user/cancelReservation" method="post">
                        <input type="hidden" name="reservationId" value="${reservation.reservationNo}" />
                        <button type="submit" onclick="return confirm('Are you sure you want to cancel this reservation?')">Cancel Reservation</button>
                    </form>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Past Reservations -->
    <div id="pastReservations" class="reservation-section">
        <h3>Past Reservations</h3>
        <table class="reservation-list">
            <thead>
            <tr>
                <th>Reservation Number</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>Travel Date</th>
                <th>Return Date</th>
                <th>Total Fare</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="reservation" items="${pastReservations}">
                <tr id="reservation-${reservation.reservationNo}">
                    <td>${reservation.reservationNo}</td>
                    <td>${reservation.originStationId}</td>
                    <td>${reservation.destinationStationId}</td>
                    <td>${reservation.ongoingDate}</td>
                    <td>${reservation.returnDate != null ? reservation.returnDate : "N/A"}</td>
                    <td>${reservation.totalFare}</td>
                    <td>
                        <span style="color: red;">Completed</span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="message">
        <p>If you need to make any changes, please contact support.</p>
    </div>
</div>

<script>
    function toggleReservationList() {
        const reservationType = document.getElementById("reservationType").value;
        const currentReservations = document.getElementById("currentReservations");
        const pastReservations = document.getElementById("pastReservations");

        // Hide both sections
        currentReservations.classList.remove("active");
        pastReservations.classList.remove("active");

        // Show the selected section
        if (reservationType === "current") {
            currentReservations.classList.add("active");
        } else if (reservationType === "past") {
            pastReservations.classList.add("active");
        }
    }

    function cancelReservation(reservationNo) {
        const confirmation = confirm("Are you sure you want to cancel this reservation?");
        if (confirmation) {
            // Redirect to cancel URL with reservation number
            location.href = '/user/cancelReservation/' + reservationNo;
        }
    }
</script>
</body>
</html>
