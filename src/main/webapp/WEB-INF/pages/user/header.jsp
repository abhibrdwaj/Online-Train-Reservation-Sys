<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }
        .header {
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo img {
            height: 50px;
        }
        .nav-links {
            display: flex;
            align-items: center;
        }
        .nav-links a {
            color: #333;
            text-decoration: none;
            margin-left: 20px;
            font-size: 16px;
        }
        .nav-links a:hover {
            color: #007bff;
        }
        .profile-icon {
            width: 24px;
            height: 24px;
            vertical-align: middle;
            margin-left: 5px;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">
        <img src="../images/trainline-logo.png" alt="Trainline Logo" class="logo">
    </div>
    <div class="nav-links">
        <a href="/user/home">Home</a>
        <a href="/user/my_bookings">My Bookings</a>
        <a href="/user/support">Support</a>
        <a href="/login">Logout </a>
    </div>
</div>
</body>
</html>