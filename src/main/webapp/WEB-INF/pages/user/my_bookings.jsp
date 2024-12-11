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
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="reservation" items="${currentReservations}">
                <tr id="reservation-${reservation.reservationNo}">
                    <td>${reservation.reservationNo}</td>
                    <td>${reservation.origin}</td>
                    <td>${reservation.destination}</td>
                    <td>${reservation.travelDate}</td>
                    <td>${reservation.returnDate != null ? reservation.returnDate : "N/A"}</td>
                    <td>${reservation.totalFare}</td>
                    <td class="actions">
                        <button class="cancel-btn" onclick="cancelReservation(${reservation.reservationNo})">Cancel</button>
                    </td>
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
            </tr>
            </thead>
            <tbody>
            <c:forEach var="reservation" items="${pastReservations}">
                <tr id="reservation-${reservation.reservationNo}">
                    <td>${reservation.reservationNo}</td>
                    <td>${reservation.origin}</td>
                    <td>${reservation.destination}</td>
                    <td>${reservation.travelDate}</td>
                    <td>${reservation.returnDate != null ? reservation.returnDate : "N/A"}</td>
                    <td>${reservation.totalFare}</td>
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
            location.href = '/user/cancelReservation/' + reservationNo;
        }
    }
</script>
</body>
</html>
