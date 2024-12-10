<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            margin: 20px auto;
        }

        .results-section {
            display: flex;
            gap: 20px;
        }

        .results {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            flex: 1;
        }

        .schedule-box {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .schedule-box:hover {
            border-color: #007BFF;
            box-shadow: 0 2px 8px rgba(0, 0, 255, 0.2);
        }

        .schedule-details {
            flex-grow: 1;
        }

        .schedule-action {
            margin-left: 20px;
        }

        h2 {
            margin-top: 0;
            color: #333;
        }

        .section-header {
            border-bottom: 2px solid #007BFF;
            padding-bottom: 10px;
            margin-bottom: 20px;
            color: #007BFF;
        }

        .no-results {
            text-align: center;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff3f3;
            color: #cc0000;
            font-weight: bold;
        }

        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Search Results</h2>
    <form action="/train-schedules/search" method="post">
        <!-- Existing search form fields -->
        <select name="sortBy">
            <option value="departureDatetime">Departure Date</option>
            <option value="arrivalDatetime">Arrival Date</option>
            <option value="travelTime">Travel Time</option>
            <option value="fare">Fare</option>
        </select>
        <button type="submit">Search</button>
    </form>

    <form action="booking/confirm" method="post">
        <div class="results-section">
            <!-- Outgoing Trains -->
            <div class="results">
                <div class="section-header">
                    <h3>Outgoing Trains: ${travelDate}</h3>
                </div>
<%--                <c:choose>--%>
                        <c:if test="${empty outgoingTrains}">
                            <p>No train schedules found.</p>
                        </c:if>


                        <c:forEach var="schedule" items="${outgoingTrains}">
                            <div class="schedule-box">
                                <div class="schedule-details">
                                    <p><strong>Train #:</strong> <span class="train-id">${schedule.trainId}</span></p>
                                    <p><strong>Departure:</strong> <span class="departure-time">${schedule.departureDatetime}</span></p>
                                    <p><strong>Arrival:</strong> <span class="arrival-time">${schedule.arrivalDatetime}</span></p>
                                    <p><strong>Travel Time:</strong> <span class="travel-time">${schedule.travelTime}</span></p>
                                    <p><strong>Transit Line:</strong> <span class="transit-line">${schedule.transitLine}</span></p>

                                    <p class="stop"><strong>Stops:</strong>
                                        <c:forEach var="stop" items="${schedule.stops}">
                                            ${stop}<c:if test="${not empty stop}">, </c:if>
                                        </c:forEach>
                                    </p>

                                    <p><strong>Fare (in USD):</strong> <span class="fare">${schedule.fare}</span></p>
                                </div>
                                <div class="schedule-action">
                                    <input type="checkbox" name="selectedSchedules" value="">
                                </div>
                            </div>
                        </c:forEach>
            </div>

            <c:if test="${not empty returnTrains}">
                <div class="results">
                    <div class="section-header">
                        <h3>Return Trains</h3>
                    </div>
                    <c:forEach var="train" items="${returnTrains}">
                        <div class="schedule-box">
                            <div class="schedule-details">
                                <p><strong>Train ID:</strong> ${train[0]}</p>
                                <p><strong>Departure:</strong> ${train[1]}</p>
                                <p><strong>Arrival:</strong> ${train[2]}</p>
                                <p><strong>Travel Time:</strong> ${train[3]}</p>
                            </div>
                            <div class="schedule-action">
                                <input type="checkbox" name="selectedSchedules" value="${train.scheduleId}">
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <!-- Submit Button -->
        <div style="text-align: center; margin-top: 20px;">
            <button type="submit">Confirm Selection</button>
        </div>
    </form>
</div>
</body>
</html>
