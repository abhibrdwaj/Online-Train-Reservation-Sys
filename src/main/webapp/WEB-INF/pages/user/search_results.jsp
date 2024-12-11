<%@ include file="../header.jsp" %>
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

        h2 {
            text-align: center;
            color: #007BFF;
            margin-bottom: 20px;
        }

        .form-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-section select, .form-section button {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        .form-section button {
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }

        .form-section button:hover {
            background-color: #0056b3;
        }

        .results-section {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .results {
            flex: 1;
            min-width: 45%;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .schedule-box {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .schedule-box:hover {
            border-color: #007BFF;
            box-shadow: 0 2px 8px rgba(0, 0, 255, 0.2);
            transform: scale(1.02);
        }

        .schedule-details {
            flex-grow: 1;
        }

        .schedule-details p {
            margin: 5px 0;
        }

        .schedule-action {
            margin-left: 20px;
        }

        .section-header {
            border-bottom: 2px solid #007BFF;
            padding-bottom: 10px;
            margin-bottom: 20px;
            color: #007BFF;
            text-align: center;
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

        .submit-btn {
            text-align: center;
            margin-top: 20px;
        }
    </style>

    <script>
        let totalFare = 0; // Initialize total fare

        function handleSelection(groupName, checkbox) {
            var element = 'input[name=' + groupName + ']';
            const checkboxes = document.querySelectorAll(element);
            let fare = 0;

            // Disable other checkboxes when one is selected
            checkboxes.forEach(cb => {
                if (cb !== checkbox) {
                    cb.disabled = checkbox.checked;  // Disable other checkboxes if one is checked
                }
            });

            // Loop through all selected checkboxes to calculate the fare
            checkboxes.forEach(cb => {
                if (cb.checked) {
                    fare += parseFloat(cb.getAttribute('data-fare')); // Add selected fare
                }
            });

            // If outgoing schedule is selected, set outgoing fare
            if (groupName === 'outgoingSelection') {
                document.getElementById('selectedOutgoingFare').value = fare;
            }

            // If return schedule is selected, set return fare
            if (groupName === 'returnSelection') {
                document.getElementById('selectedReturnFare').value = fare;
            }
        }

    </script>
</head>
<body>
<div class="container">

    <h2>Search Results</h2>

    <form action="/train-schedules/search" method="post" class="form-section">
        <div>
            <label for="sortBy">Sort By:</label>
            <select name="sortBy" id="sortBy">
                <option value="departureDatetime">Departure Time</option>
                <option value="arrivalDatetime">Arrival Time</option>
                <option value="travelTime">Travel Time</option>
                <option value="fare">Fare</option>
            </select>
        </div>
        <button type="submit">Search</button>
    </form>

    <form action="/train-schedules/confirm-booking" method="post">
        <div class="results-section">
            <!-- Outgoing Trains -->
            <div class="results">
                <div class="section-header">
                    <h3>Outgoing Trains: ${travelDate}</h3>
                </div>

                <c:if test="${empty outgoingTrains}">
                    <div class="no-results">No train schedules found.</div>
                </c:if>

                <c:forEach var="schedule" items="${outgoingTrains}">
                    <div class="schedule-box">
                        <div class="schedule-details">
                            <p><strong>Train #:</strong> ${schedule.trainId}</p>
                            <p><strong>Departure:</strong> ${schedule.departureTime}</p>
                            <p><strong>Arrival:</strong> ${schedule.arrivalTime}</p>
                            <p><strong>Travel Time:</strong> ${schedule.travelTime}</p>
                            <p><strong>Transit Line:</strong> ${schedule.transitLine}</p>
                            <p><strong>Stops:</strong> <c:forEach var="stop" items="${schedule.stops}">${stop}, </c:forEach></p>
                            <p><strong>Fare:</strong> $${schedule.fare}</p>
                        </div>
                        <div class="schedule-action">
                            <input type="checkbox" name="outgoingSelection" value="${schedule.scheduleId}" data-fare="${schedule.fare}" onchange="handleSelection('outgoingSelection', this)">
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Return Trains -->
            <c:if test="${not empty returnTrains}">
                <div class="results">
                    <div class="section-header">
                        <h3>Return Trains: ${returnDate}</h3>
                    </div>

                    <c:forEach var="schedule" items="${returnTrains}">
                        <div class="schedule-box">
                            <div class="schedule-details">
                                <p><strong>Train #:</strong> ${schedule.trainId}</p>
                                <p><strong>Departure:</strong> ${schedule.departureTime}</p>
                                <p><strong>Arrival:</strong> ${schedule.arrivalTime}</p>
                                <p><strong>Travel Time:</strong> ${schedule.travelTime}</p>
                                <p><strong>Transit Line:</strong> ${schedule.transitLine}</p>
                                <p><strong>Stops:</strong> <c:forEach var="stop" items="${schedule.stops}">${stop}, </c:forEach></p>
                                <p><strong>Fare:</strong> $${schedule.fare}</p>
                            </div>
                            <div class="schedule-action">
                                <input type="checkbox" name="returnSelection" value="${schedule.scheduleId}" data-fare="${schedule.fare}" onchange="handleSelection('returnSelection', this)">
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <!-- Hidden fields to store fares -->
        <input type="hidden" name="selectedOutgoingFare" id="selectedOutgoingFare">
        <input type="hidden" name="selectedReturnFare" id="selectedReturnFare">
        <input type="hidden" name="origin" id="origin" value="${origin}">
        <input type="hidden" name="destination" id="destination" value="${destination}">
        <input type="hidden" name="travelDate" id="travelDate" value="${travelDate}">
        <input type="hidden" name="returnDate" id="returnDate" value="${returnDate}">
        <input type="hidden" name="tripType" id="tripType" value="${tripType}">



        <!-- Submit Button -->
        <div class="submit-btn">
            <button type="submit">Confirm Selection</button>
        </div>
    </form>
</div>
</body>
</html>
