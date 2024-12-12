<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Train Schedules</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Train Schedules</h1>
    <form action="/customerRep" method="get">
        <button type="submit" class="menu-item">Home Page</button>
    </form>
    <table id="schedulesTable">
        <thead>
            <tr>
                <th>Schedule ID</th>
                <th>Train ID</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Direction</th>
            </tr>
        </thead>
        <tbody>
            <!-- Schedules will be inserted here -->
        </tbody>
    </table>

    <script>
    $(document).ready(function() {
    $.ajax({
        url: '/schedules',
        method: 'GET',
        dataType: 'json',
        success: function(schedules) {
            var tableBody = $('#schedulesTable tbody');
            schedules.forEach(function(schedule) {
                // var row = '<tr>' +
                //     '<td>' + schedule.schedule_id + '</td>' +
                //     '<td>' + schedule.train_id + '</td>' +
                //     '<td>' + new Date(schedule.departure_datetime).toLocaleString() + '</td>' +
                //     '<td>' + new Date(schedule.arrival_datetime).toLocaleString() + '</td>' +
                //     '<td>' + schedule.travel_time + '</td>' +
                //     '<td>' +
                //     '<button class="edit-btn" data-id="' + schedule.schedule_id + '">Edit</button>' +
                //     '<button class="save-btn" style="display:none;">Save</button>' +
                //     '<button class="delete-btn" data-id="' + schedule.schedule_id + '">Delete</button>' +
                //     '</td>' +
                //     '</tr>';
                var row = '<tr data-id="' + schedule.scheduleId + '">' +
                        '<td>' + schedule.scheduleId + '</td>' +
                        '<td>' + schedule.trainId + '</td>' +
                        '<td><input type="text" value="' + (schedule.departureTime).toLocaleString() + '" disabled /></td>' +
                        '<td><input type="text" value="' + (schedule.arrivalTime).toLocaleString() + '" disabled /></td>' +
                        '<td><input type="text" value="' + schedule.direction + '" disabled /></td>' +
                        '<td>' +
                        '<button class="edit-btn">Edit</button>' +
                        '<button class="save-btn" style="display:none;">Save</button>' +
                        '<button class="delete-btn" data-id="' + schedule.scheduleId + '">Delete</button>' +
                        '</td>' +
                        '</tr>';
                tableBody.append(row);
            });
        },
        error: function(xhr, status, error) {
            console.error("Error fetching schedules:", error);
            $('#schedulesTable tbody').html('<tr><td colspan="6">Error loading schedules. Please try again later.</td></tr>');
        }
    });

    // // Handle edit button click
    // $(document).on('click', '.edit-btn', function() {
    //     var schedule_id = $(this).data('id');
    //     // Implement edit functionality (e.g., open a modal with a form)
    //     // You'll need to create a form and send a PUT request to update the schedule
    // });

    // Handle Edit button click
    $(document).on('click', '.edit-btn', function() {
        var row = $(this).closest('tr');
        row.find('input').prop('disabled', false); // Enable input fields
        $(this).hide(); // Hide Edit button
        row.find('.save-btn').show(); // Show Save button
    });

    // Handle Save button click
    $(document).on('click', '.save-btn', function() {
        var row = $(this).closest('tr');
        var schedule_id = row.data('id');
        
        var updatedSchedule = {
            scheduleId: schedule_id,
            trainId: row.find('input').eq(0).val(),
            departureTime: row.find('input').eq(1).val(), // Convert to ISO string
            arrivalTime: row.find('input').eq(2).val(), // Convert to ISO string
            direction: row.find('input').eq(3).val()
        };

        // Send the updated schedule to the backend
        $.ajax({
            url: '/update/' + schedule_id,
            method: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(updatedSchedule),
            success: function(response) {
                alert('Schedule updated successfully!');
                location.reload(); // Reload the page or update the UI as needed
            },
            error: function(xhr, status, error) {
                console.error("Error updating schedule:", error);
                alert('Error updating schedule. Please try again.');
            }
        });
    });

    // Handle delete button click
    $(document).on('click', '.delete-btn', function() {
        var schedule_id = $(this).data('id');
        if (confirm('Are you sure you want to delete this schedule?')) {
            $.ajax({
                url: '/delete/' + schedule_id,
                method: 'DELETE',
                success: function() {
                    alert('Schedule deleted successfully');
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error("Error deleting schedule:", error);
                    alert('Error deleting schedule. Please try again.');
                }
            });
        }
    });
});

    </script>
</body>
</html>
