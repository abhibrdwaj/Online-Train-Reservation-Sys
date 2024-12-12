<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Station Schedules</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #ffffff;
            color: #000000;
        }
        h1 {
            color: #000000;
        }
        button {
            background-color: #000000;
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }
        #scheduleTableContainer {
            margin-top: 20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background-color: white;
        }
        th, td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #000000;
        }
        th {
            background-color: #000000;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f0f0f0;
        }
        .back-button {
            margin-top: 20px;
            background-color: #000000;
        }
    </style>
</head>
<body>
    <h1>Station Schedules</h1>
    <label for="stationName">Station Name:</label>
    <input type="text" id="stationName" name="stationName" required>

    <button onclick="loadSchedules()">Load Station Schedules</button>
    <div id="scheduleTableContainer"></div>
    <!-- <button class="back-button" onclick="goBack()">Back to Home</button> -->
    <form action="/customerRep" method="get">
        <button type="submit" class="menu-item">Home Page</button>
    </form>

    <script>
        function loadSchedules() {
            var stationName = $('#stationName').val();
            if (!stationName) {
                alert("Please enter a station name.");
                return;
            }

            $.ajax({
                url: '/stationschedules',
                type: 'GET',
                dataType: 'json',
                data: { stationName: stationName },
                success: function(data) {
                    displaySchedules(data);
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching schedules:', error);
                    $('#scheduleTableContainer').html('<p>Error loading schedules. Please try again.</p>');
                }
            });
        }

        function displaySchedules(schedules) {
            var tableHtml = '<table><tr><th>Schedule Id</th><th>Train Id</th><th>Departure Date Time</th><th>Arrival Date Time</th><th>Travel Time</th></tr>';
            
            schedules.forEach(function(schedule) {
                tableHtml += '<tr>';
                tableHtml += '<td>' + schedule.scheduleId + '</td>';
                tableHtml += '<td>' + schedule.trainId + '</td>';
                tableHtml += '<td>' + schedule.departureTime + '</td>';
                tableHtml += '<td>' + schedule.arrivalTime + '</td>';
                tableHtml += '<td>' + schedule.direction + '</td>';
                tableHtml += '</tr>';
            });
            
            tableHtml += '</table>';
            $('#scheduleTableContainer').html(tableHtml);
        }

//         function goBack() {
//     window.location.href = 'customerRep';
// }
    </script>
</body>
</html>