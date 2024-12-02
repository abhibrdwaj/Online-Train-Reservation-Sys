<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Make Reservation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: auto;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Train Search</h2>
    <form action="searchResults.jsp" method="post">
        <div class="form-group">
            <label for="origin">Origin:</label>
            <input type="text" id="origin" name="origin" placeholder="Enter origin" required>
        </div>
        <div class="form-group">
            <label for="destination">Destination:</label>
            <input type="text" id="destination" name="destination" placeholder="Enter destination" required>
        </div>
        <div class="form-group">
            <label for="tripType">Trip Type:</label>
            <select id="tripType" name="tripType" onchange="toggleReturnDate()" required>
                <option value="one-way">One Way</option>
                <option value="round-trip">Round Trip</option>
            </select>
        </div>
        <div class="form-group">
            <label for="travelDate">Travel Date:</label>
            <input type="date" id="travelDate" name="travelDate" required>
        </div>
        <div class="form-group" id="returnDateGroup" style="display: none;">
            <label for="returnDate">Return Date:</label>
            <input type="date" id="returnDate" name="returnDate">
        </div>
        <div class="form-group">
            <label for="adults">Number of Adults:</label>
            <input type="number" id="adults" name="adults" value="1" min="0" required>
        </div>
        <div class="form-group">
            <label for="children">Number of Children:</label>
            <input type="number" id="children" name="children" value="0" min="0">
        </div>
        <div class="form-group">
            <label for="seniors">Number of Senior Citizens:</label>
            <input type="number" id="seniors" name="seniors" value="0" min="0">
        </div>

        <div class="form-group">
            <button type="submit">Search Trains</button>
        </div>
        <div class="form-group">
            <button type="button" onclick="refreshPage()">Refresh Search</button>
        </div>
    </form>
</div>

<script>
    function toggleReturnDate() {
        const tripType = document.getElementById("tripType").value;
        const returnDateGroup = document.getElementById("returnDateGroup");
        if (tripType === "round-trip") {
            returnDateGroup.style.display = "block";
        } else {
            returnDateGroup.style.display = "none";
        }
    }
    function refreshPage() {
        location.reload();
    }
</script>

</body>
</html>
