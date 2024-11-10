CREATE DATABASE RailwayBookingSystem;
Use RailwayBookingSystem;

CREATE TABLE Stations (
    station_id INT PRIMARY KEY,
    station_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL
);

CREATE TABLE TransitLines (
    name VARCHAR(100) PRIMARY KEY,
    origin_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    fare DECIMAL(10, 2) NOT NULL,
    no_of_stops INT NOT NULL,
    FOREIGN KEY (origin_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES Stations(station_id)
);

CREATE TABLE Trains (
    train_id INT AUTO_INCREMENT PRIMARY KEY,
    transit_line_name VARCHAR(100),
    FOREIGN KEY (transit_line_name) REFERENCES TransitLines(name)
) AUTO_INCREMENT = 1000;

-- Train Schedule Data Tables
CREATE TABLE Schedules (
    schedule_id INT UNIQUE NOT NULL,
    train_id INT,
    departure_datetime DATETIME NOT NULL,
    arrival_datetime DATETIME NOT NULL,
    travel_time TIME NOT NULL,
    PRIMARY KEY (train_id, departure_datetime),
    FOREIGN KEY (train_id) REFERENCES Trains(train_id)
);

CREATE TABLE TrainStops (
    schedule_id INT,
    station_id INT,
    arrival_datetime DATETIME,
    departure_datetime DATETIME,
    stop_number INT NOT NULL,
    PRIMARY KEY (schedule_id, station_id),
    FOREIGN KEY (schedule_id) REFERENCES Schedules(schedule_id),
    FOREIGN KEY (station_id) REFERENCES Stations(station_id)
);

-- User Data Tables
CREATE TABLE Users (
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    username VARCHAR(100) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    email_address VARCHAR(100) UNIQUE,
    social_security_number VARCHAR(11) UNIQUE
);

-- If required later: have two tables (Coming Soon)
-- CREATE TABLE Customers (
--     customer_id INT PRIMARY KEY,
--     email_address VARCHAR(100) UNIQUE NOT NULL,
--     FOREIGN KEY (customer_id) REFERENCES Users(user_id)
-- );

-- CREATE TABLE Employees (
--     employee_id INT PRIMARY KEY,
--     social_security_number VARCHAR(11) UNIQUE NOT NULL,
--     FOREIGN KEY (employee_id) REFERENCES Users(user_id)
-- );

-- Reservation Data Tables
CREATE TABLE Reservations (
    reservation_no INT PRIMARY KEY,
    customer VARCHAR(100),
    reservation_date DATE NOT NULL,
    origin_station_id INT,
    destination_station_id INT,
    schedule_id INT,
    departure_datetime DATETIME NOT NULL,
    total_fare DECIMAL(10, 2) NOT NULL,
    is_round_trip BOOLEAN NOT NULL,
    FOREIGN KEY (customer) REFERENCES Users(username),
    FOREIGN KEY (origin_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (schedule_id) REFERENCES Schedules(schedule_id)
);

-- Access Control Tables (Coming Soon)
CREATE TABLE UserRoles (
    user_role_id INT PRIMARY KEY,
    username VARCHAR(100),
    role_type ENUM('manager', 'customer_rep', 'customer') NOT NULL,
    FOREIGN KEY (username) REFERENCES Users(username)
);

-- Forum and Customer Service Tables (Coming Soon)
-- CREATE TABLE Questions (
--     question_id INT PRIMARY KEY,
--     customer_id INT,
--     question_text TEXT NOT NULL,
--     timestamp DATETIME NOT NULL,
--     FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
-- );

-- CREATE TABLE Answers (
--     answer_id INT PRIMARY KEY,
--     question_id INT,
--     employee_id INT,
--     answer_text TEXT NOT NULL,
--     timestamp DATETIME NOT NULL,
--     FOREIGN KEY (question_id) REFERENCES Questions(question_id),
--     FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
-- );


-- INSERT User data

INSERT into Users (last_name, first_name, username, password, email_address)
VALUES ('Bharadwaj', 'Abhinav', 'customer', 'password123', 'abhinav.bharadwaj@example.com');

SELECT * FROM Users;

