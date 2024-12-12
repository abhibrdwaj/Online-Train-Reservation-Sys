<%@ include file="../header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #007BFF;
        }

        .details {
            margin: 20px 0;
        }

        .details p {
            font-size: 16px;
            margin: 8px 0;
        }

        .details .highlight {
            font-weight: bold;
        }

        .button-container {
            text-align: center;
            margin-top: 30px;
        }

        .home-btn {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .home-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Booking Confirmation</h2>

    <div class="details">
        <p><span class="highlight">Customer:</span> ${reservation.customer}</p>
        <p><span class="highlight">Reservation Number:</span> ${reservation.reservationNo}</p>
        <p><span class="highlight">Reservation Date:</span> ${reservation.reservationDate}</p>

        <p><span class="highlight">Origin Station:</span> ${reservation.originStationId}</p>
        <p><span class="highlight">Destination Station:</span> ${reservation.destinationStationId}</p>

        <p><span class="highlight">Ongoing Date:</span> ${reservation.ongoingDate}</p>
        <p><span class="highlight">Total Fare:</span> $${reservation.totalFare}</p>
    </div>

    <c:if test="${reservation.roundTrip}">
        <div class="details">
            <p><span class="highlight">Round Trip:</span> Yes</p>
            <p><span class="highlight">Return Date:</span> ${reservation.returnDate}</p>
            <p><span class="highlight">Return Schedule ID:</span> ${reservation.returnScheduleId}</p>
        </div>
    </c:if>

    <div class="button-container">
        <a href="/user/home" class="home-btn">Go to Home Page</a>
    </div>
</div>
</body>
</html>
