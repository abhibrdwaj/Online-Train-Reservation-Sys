CREATE DATABASE RailwayBookingSystem;
Use RailwayBookingSystem;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS TrainStops;
DROP TABLE IF EXISTS Reservations;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Schedules;
DROP TABLE IF EXISTS Trains;
DROP TABLE IF EXISTS TransitLines;
DROP TABLE IF EXISTS Stations;

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
    direction ENUM('Forward', 'Reverse') NOT NULL,
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
    social_security_number VARCHAR(11) UNIQUE,
    role ENUM('ADMIN', 'CUSTOMER', 'CUSTOMER_REP') NOT NULL -- Changed column
);

-- Added new columns below
-- Reservation Data Tables
CREATE TABLE Reservations (
    reservation_no INT PRIMARY KEY,
    customer VARCHAR(100),
    reservation_date DATE NOT NULL,
    origin_station_id INT,
    destination_station_id INT,
    ongoing_schedule_id INT,
    return_schedule_id INT, -- New Column
    total_fare DECIMAL(10, 2) NOT NULL,
    is_round_trip BOOLEAN DEFAULT 0,
    ticket_details JSON,
    FOREIGN KEY (customer) REFERENCES Users(username),
    FOREIGN KEY (origin_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (ongoing_schedule_id) REFERENCES Schedules(schedule_id),
    FOREIGN KEY (return_schedule_id) REFERENCES Schedules(schedule_id)
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
SELECT * FROM users;

INSERT into Users (last_name, first_name, username, password, email_address, role)
VALUES
    ('Bharadwaj', 'Abhinav', 'customer1', '$2a$10$AaFBB8rM80GIf/Yr/pc3TOhD3WGA.T4/Dfcub84u7Fy589Yeo7w9O', 'abhinav.bharadwaj@example.com', 'CUSTOMER'),
    ('User 1','Admin', 'adminuser1', '2a$10$AaFBB8rM80GIf/Yr/pc3TOhD3WGA.T4/Dfcub84u7Fy589Yeo7w9O', 'abhinav.admin@example.com', 'ADMIN'),
    ('Rep 1','Customer', 'customerrep1', '2a$10$AaFBB8rM80GIf/Yr/pc3TOhD3WGA.T4/Dfcub84u7Fy589Yeo7w9O', 'abhinav.rep1@example.com', 'CUSTOMER_REP'),
    ('Rep 2','Customer', 'customerrep2', '2a$10$AaFBB8rM80GIf/Yr/pc3TOhD3WGA.T4/Dfcub84u7Fy589Yeo7w9O', 'abhinav.rep2@example.com', 'CUSTOMER_REP');

-- Insert stations into the Stations table
INSERT INTO Stations (station_id, station_name, city, state)
VALUES
    (1, 'Newark Penn Station', 'Newark', 'New Jersey'),
    (2, 'Secaucus Junction', 'Secaucus', 'New Jersey'),
    (3, 'Hoboken Terminal', 'Hoboken', 'New Jersey'),
    (4, 'Princeton Junction', 'Princeton', 'New Jersey'),
    (5, 'Trenton Transit Center', 'Trenton', 'New Jersey'),
    (6, 'New Brunswick Station', 'New Brunswick', 'New Jersey'),
    (7, 'Metropark Station', 'Iselin', 'New Jersey'),
    (8, 'Penn Station', 'New York', 'New York'); -- Adding an NY station for inter-state travel

-- Insert transit lines into the TransitLines table
INSERT INTO TransitLines (name, origin_station_id, destination_station_id, fare, no_of_stops)
VALUES
    ('Northeast Corridor', 5, 1, 45.00, 3), -- Trenton to Newark Penn
    ('North Jersey Coast Line', 1, 7, 40.00, 4), -- Newark Penn to Metropark
    ('Midtown Direct', 3, 8, 55.00, 2), -- Hoboken to NY Penn
    ('Princeton Shuttle', 4, 6, 30.00, 1), -- Princeton Junction to New Brunswick
    ('Secaucus Express', 2, 8, 50.00, 1), -- Secaucus Junction to NY Penn
    ('Trenton Local', 5, 4, 35.00, 2); -- Trenton to Princeton Junction


INSERT INTO Trains (transit_line_name)
VALUES
    ('Northeast Corridor'), ('Northeast Corridor'), ('Northeast Corridor'),
    ('Northeast Corridor'), ('Northeast Corridor'),
    ('North Jersey Coast Line'), ('North Jersey Coast Line'), ('North Jersey Coast Line'),
    ('North Jersey Coast Line'), ('North Jersey Coast Line'),
    ('Midtown Direct'), ('Midtown Direct'), ('Midtown Direct'),
    ('Midtown Direct'), ('Midtown Direct'),
    ('Princeton Shuttle'), ('Princeton Shuttle'), ('Princeton Shuttle'),
    ('Princeton Shuttle'), ('Princeton Shuttle'),
    ('Secaucus Express'), ('Secaucus Express'), ('Secaucus Express'),
    ('Secaucus Express'), ('Secaucus Express'),
    ('Trenton Local'), ('Trenton Local'), ('Trenton Local'),
    ('Trenton Local'), ('Trenton Local');


-- Insert sample schedules into the Schedules table
INSERT INTO Schedules (schedule_id, train_id, departure_datetime, arrival_datetime, travel_time)
VALUES
-- Morning Trains
(1, 1000, '2024-12-10 06:00:00', '2024-12-10 08:00:00', '02:00:00'),
(2, 1005, '2024-12-10 07:30:00', '2024-12-10 09:00:00', '01:30:00'),
-- Brunch Trains
(3, 1010, '2024-12-10 10:00:00', '2024-12-10 12:30:00', '02:30:00'),
(4, 1015, '2024-12-10 11:00:00', '2024-12-10 11:30:00', '00:30:00'),
-- Afternoon Trains
(5, 1020, '2024-12-10 13:00:00', '2024-12-10 15:00:00', '02:00:00'),
(6, 1025, '2024-12-10 14:30:00', '2024-12-10 16:30:00', '02:00:00'),
-- Evening Trains
(7, 1001, '2024-12-10 18:00:00', '2024-12-10 20:30:00', '02:30:00'),
(8, 1006, '2024-12-10 19:00:00', '2024-12-10 21:00:00', '02:00:00'),
-- Night Trains
(9, 1011, '2024-12-10 22:00:00', '2024-12-11 00:30:00', '02:30:00'),
(10, 1016, '2024-12-10 23:30:00', '2024-12-11 00:00:00', '00:30:00');


-- Insert stops for Schedule 1 (Train 1000 on Northeast Corridor)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (1, 5, '2024-12-10 06:00:00', '2024-12-10 06:05:00', 1), -- Trenton
    (1, 6, '2024-12-10 06:45:00', '2024-12-10 06:50:00', 2), -- New Brunswick
    (1, 7, '2024-12-10 07:30:00', '2024-12-10 07:35:00', 3), -- Metropark
    (1, 1, '2024-12-10 08:00:00', '2024-12-10 08:05:00', 4); -- Newark Penn

-- Insert stops for Schedule 2 (Train 1005 on North Jersey Coast Line)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (2, 1, '2024-12-10 07:30:00', '2024-12-10 07:35:00', 1), -- Newark Penn
    (2, 6, '2024-12-10 08:00:00', '2024-12-10 08:05:00', 2), -- New Brunswick
    (2, 7, '2024-12-10 08:30:00', '2024-12-10 08:35:00', 3); -- Metropark

-- Insert stops for Schedule 3 (Train 1010 on Midtown Direct)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (3, 3, '2024-12-10 10:00:00', '2024-12-10 10:05:00', 1), -- Hoboken Terminal
    (3, 2, '2024-12-10 11:00:00', '2024-12-10 11:05:00', 2), -- Secaucus Junction
    (3, 8, '2024-12-10 12:30:00', '2024-12-10 12:35:00', 3); -- New York Penn

-- Insert stops for Schedule 4 (Train 1015 on Raritan Valley Line)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (4, 4, '2024-12-10 11:00:00', '2024-12-10 11:05:00', 1), -- Summit
    (4, 6, '2024-12-10 11:30:00', '2024-12-10 11:35:00', 2), -- New Brunswick
    (4, 1, '2024-12-10 12:00:00', '2024-12-10 12:05:00', 3); -- Newark Penn

-- Insert stops for Schedule 5 (Train 1020 on Northeast Corridor)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (5, 5, '2024-12-10 13:00:00', '2024-12-10 13:05:00', 1), -- Trenton
    (5, 6, '2024-12-10 13:30:00', '2024-12-10 13:35:00', 2), -- New Brunswick
    (5, 7, '2024-12-10 14:00:00', '2024-12-10 14:05:00', 3); -- Metropark

-- Insert stops for Schedule 6 (Train 1025 on North Jersey Coast Line)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (6, 1, '2024-12-10 14:30:00', '2024-12-10 14:35:00', 1), -- Newark Penn
    (6, 6, '2024-12-10 15:00:00', '2024-12-10 15:05:00', 2), -- New Brunswick
    (6, 7, '2024-12-10 15:30:00', '2024-12-10 15:35:00', 3); -- Metropark

-- Insert stops for Schedule 7 (Train 1001 on Midtown Direct)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (7, 3, '2024-12-10 18:00:00', '2024-12-10 18:05:00', 1), -- Hoboken Terminal
    (7, 2, '2024-12-10 19:00:00', '2024-12-10 19:05:00', 2), -- Secaucus Junction
    (7, 8, '2024-12-10 20:30:00', '2024-12-10 20:35:00', 3); -- New York Penn

-- Insert stops for Schedule 8 (Train 1006 on Raritan Valley Line)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (8, 4, '2024-12-10 19:00:00', '2024-12-10 19:05:00', 1), -- Summit
    (8, 6, '2024-12-10 19:30:00', '2024-12-10 19:35:00', 2), -- New Brunswick
    (8, 1, '2024-12-10 20:00:00', '2024-12-10 20:05:00', 3); -- Newark Penn

-- Insert stops for Schedule 9 (Train 1011 on Northeast Corridor)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (9, 5, '2024-12-10 22:00:00', '2024-12-10 22:05:00', 1), -- Trenton
    (9, 6, '2024-12-10 22:45:00', '2024-12-10 22:50:00', 2), -- New Brunswick
    (9, 7, '2024-12-10 23:30:00', '2024-12-10 23:35:00', 3), -- Metropark
    (9, 1, '2024-12-11 00:00:00', '2024-12-11 00:05:00', 4); -- Newark Penn

-- Insert stops for Schedule 10 (Train 1016 on Midtown Direct)
INSERT INTO TrainStops (schedule_id, station_id, arrival_datetime, departure_datetime, stop_number)
VALUES
    (10, 3, '2024-12-10 23:30:00', '2024-12-10 23:35:00', 1), -- Hoboken Terminal
    (10, 2, '2024-12-11 00:00:00', '2024-12-11 00:05:00', 2), -- Secaucus Junction
    (10, 8, '2024-12-11 00:30:00', '2024-12-11 00:35:00', 3); -- New York Penn


# INSERT INTO Reservations (reservation_no, customer, reservation_date, origin_station_id, destination_station_id, ongoing_schedule_id, return_schedule_id, total_fare, is_round_trip, ticket_details)
# VALUES
#     (4, 'john_doe', '2024-01-10', 1, 2, 101, , 50.00, FALSE),
#     (5, 'jane_smith', '2024-01-15', 2, 3, 102, '2024-01-15 07:30:00', 45.00, TRUE),
#     (6, 'customer', '2024-02-05', 3, 4, 103, '2024-02-05 10:00:00', 60.00, FALSE),
#     (7, 'jane_smith', '2024-02-20', 4, 5, 101, '2024-02-20 11:00:00', 40.00, TRUE),
#     (8, 'john_doe', '2024-03-01', 1, 3, 102, '2024-03-01 13:00:00', 75.00, FALSE),
#     (9, 'customer', '2024-03-15', 3, 5, 103, '2024-03-15 14:30:00', 65.00, TRUE),
#     (10, 'jane_smith', '2024-03-25', 2, 4, 101, '2024-03-25 18:00:00', 55.00, FALSE),
#     (11, 'john_doe', '2024-01-20', 4, 1, 102, '2024-01-20 22:00:00', 50.00, TRUE);



SELECT * FROM Users;

UPDATE Users SET role = 'ADMIN' WHERE username = 'customer1';




