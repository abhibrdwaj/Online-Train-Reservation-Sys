<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Reservations</title>
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
    <script type="text/javascript">
        function searchReservations() {
            var date = $('#date').val();
            var transitLineName = $('#transitLineName').val();

            $.ajax({
                url: '/reservations',
                type: 'GET',
                data: {
                    date: date,
                    transitLineName: transitLineName
                },
                success: function(data) {
                    // Clear previous results
                    $('#results').empty();
                    
                    // Populate results in the table
                    if (data.length > 0) {
                        var table = '<table border="1"><tr><th>Reservation no</th><th>Reservation date</th><th>Origin station id</th><th>Destination station id</th><th>Schedule id</th><th>Departure datetime</th><th>Total fare</th><th>Round trip</th></tr>';
                        $.each(data, function(index, reservation) {
                            table += '<tr><td>' + reservation.reservation_no + '</td><td>' + reservation.reservation_date + '</td><td>' + reservation.origin_station_id + '</td><td>' + reservation.destination_station_id + '</td><td>' + reservation.schedule_id + '</td><td>' + reservation.departure_datetime + '</td><td>' + reservation.total_fare + '</td><td>' + reservation.is_round_trip + '</td></tr>';
                        });
                        table += '</table>';
                        $('#results').html(table);
                    } else {
                        $('#results').html('<p>No reservations found.</p>');
                    }
                },
                error: function() {
                    alert('Error retrieving reservations.');
                }
            });
        }
    </script>
</head>
<body>

<h1>Search Reservations</h1>
<form onsubmit="event.preventDefault(); searchReservations();">
    <label for="date">Reservation Date:</label>
    <input type="text" id="date" name="date" placeholder="yyyy-MM-dd" required>
    <br>
    <label for="transitLineName">Transit Line Name:</label>
    <input type="text" id="transitLineName" name="transitLineName" required>
    <br>
    <button type="submit">Search</button>
</form>

<div id="results"></div>

<form action="/customerRep" method="get">
    <button type="submit" class="menu-item">Home Page</button>
</form>

</body>
</html>