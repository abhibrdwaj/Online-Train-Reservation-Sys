<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Representative Portal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff; /* White background */
            color: #333333; /* Dark text for readability */
            text-align: center;
            padding: 50px;
        }
        h1 {
            margin-bottom: 40px;
            color: #000000; /* Black title */
        }
        .menu {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .menu-item {
            background-color: #f0f0f0; /* Light gray background for buttons */
            color: #000000; /* Black text */
            border: 1px solid #cccccc; /* Light gray border */
            border-radius: 5px;
            padding: 15px 30px;
            font-size: 18px;
            margin: 10px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, border-color 0.3s;
        }
        .menu-item:hover {
            background-color: #e0e0e0; /* Darker gray on hover */
            transform: scale(1.05);
            border-color: #999999; /* Darker border on hover */
        }
        .logout {
            margin-top: 30px;
            background-color: #ffcccc; /* Light red for logout button */
        }
        .logout:hover {
            background-color: #ff9999; /* Darker red on hover */
        }
    </style>
</head>
<body>
    <h1>Welcome to the Customer Representative Portal</h1>
    <div class="menu">
        <form action="/editDelete" method="get">
            <button type="submit" class="menu-item">Edit/Delete Train Schedules</button>
        </form>
        <form action="/replyQuestions" method="get">
            <button type="submit" class="menu-item">Reply to Customer Questions</button>
        </form>
        <form action="/customerReservations" method="get">
            <button type="submit" class="menu-item">Customer Reservations</button>
        </form>
        <form action="/stationSchedules" method="get">
            <button type="submit" class="menu-item">Station Schedules</button>
        </form>
        <form action="/endpage" method="post">
            <button type="submit" class="menu-item logout">Logout</button>
        </form>
    </div>
</body>
</html>