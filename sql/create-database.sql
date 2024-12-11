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
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    direction ENUM('Forward', 'Reverse') NOT NULL,
    PRIMARY KEY (train_id, departure_time),
    FOREIGN KEY (train_id) REFERENCES Trains(train_id)
);

CREATE TABLE TrainStops (
    schedule_id INT,
    station_id INT,
    arrival_time TIME,
    departure_time TIME,
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
    reservation_no INT PRIMARY KEY AUTO_INCREMENT,
    customer VARCHAR(100),
    reservation_date DATE NOT NULL,
    ongoing_date DATE NOT NULL,
    return_date DATE,
    origin_station_id INT,
    destination_station_id INT,
    ongoing_schedule_id INT,
    return_schedule_id INT, -- New Column
    total_fare DECIMAL(10, 2) NOT NULL,
    is_round_trip BOOLEAN DEFAULT 0,
    FOREIGN KEY (customer) REFERENCES Users(username),
    FOREIGN KEY (origin_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (ongoing_schedule_id) REFERENCES Schedules(schedule_id),
    FOREIGN KEY (return_schedule_id) REFERENCES Schedules(schedule_id)
) AUTO_INCREMENT = 100;

-- Forum and Customer Service Tables (Coming Soon)
-- CREATE TABLE Questions (
--     question_id INT PRIMARY KEY,
--     username INT,
--     question_text TEXT NOT NULL,
--     timestamp DATETIME NOT NULL,
--     FOREIGN KEY (username) REFERENCES Users(username)
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
SELECT * FROM TransitLines;

INSERT into Users (last_name, first_name, username, password, email_address, role)
VALUES
    ('Bharadwaj', 'Abhinav', 'customer2', '$2a$10$GfxDqCBShPTzNZ8IhdvJfuL4oRH3EJOrq86usNW0N7j/t.n7aar..', 'abhinav.bharadwaj@example.com', 'CUSTOMER'),
    ('User 1','Admin', 'adminuser1', '$2a$10$GfxDqCBShPTzNZ8IhdvJfuL4oRH3EJOrq86usNW0N7j/t.n7aar..', 'abhinav.admin@example.com', 'ADMIN'),
    ('Rep 1','Customer', 'customerrep1', '$2a$10$GfxDqCBShPTzNZ8IhdvJfuL4oRH3EJOrq86usNW0N7j/t.n7aar..', 'abhinav.rep1@example.com', 'CUSTOMER_REP'),
    ('Rep 2','Customer', 'customerrep2', '$2a$10$GfxDqCBShPTzNZ8IhdvJfuL4oRH3EJOrq86usNW0N7j/t.n7aar..', 'abhinav.rep2@example.com', 'CUSTOMER_REP');

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

# -- Insert transit lines into the TransitLines table
# INSERT INTO TransitLines (name, origin_station_id, destination_station_id, fare, no_of_stops)
# VALUES
#     ('Northeast Corridor', 5, 1, 45.00, 3), -- Trenton to Newark Penn
#     ('North Jersey Coast Line', 1, 7, 40.00, 4), -- Newark Penn to Metropark
#     ('Midtown Direct', 3, 8, 55.00, 2), -- Hoboken to NY Penn
#     ('Princeton Shuttle', 4, 6, 30.00, 1), -- Princeton Junction to New Brunswick
#     ('Secaucus Express', 2, 8, 50.00, 1), -- Secaucus Junction to NY Penn
#     ('Trenton Local', 5, 4, 35.00, 2); -- Trenton to Princeton Junction

INSERT INTO TransitLines (name, origin_station_id, destination_station_id, fare, no_of_stops)
VALUES ('Northeast Corridor', 8, 5, 50.00, 6),
        ('Central Jersey Transit', 6, 8, 60.00, 2);




# INSERT INTO Trains (transit_line_name)
# VALUES
#     ('Northeast Corridor'), ('Northeast Corridor'), ('Northeast Corridor'),
#     ('Northeast Corridor'), ('Northeast Corridor'),
#     ('North Jersey Coast Line'), ('North Jersey Coast Line'), ('North Jersey Coast Line'),
#     ('North Jersey Coast Line'), ('North Jersey Coast Line'),
#     ('Midtown Direct'), ('Midtown Direct'), ('Midtown Direct'),
#     ('Midtown Direct'), ('Midtown Direct'),
#     ('Princeton Shuttle'), ('Princeton Shuttle'), ('Princeton Shuttle'),
#     ('Princeton Shuttle'), ('Princeton Shuttle'),
#     ('Secaucus Express'), ('Secaucus Express'), ('Secaucus Express'),
#     ('Secaucus Express'), ('Secaucus Express'),
#     ('Trenton Local'), ('Trenton Local'), ('Trenton Local'),
#     ('Trenton Local'), ('Trenton Local');


INSERT INTO Trains (transit_line_name)
VALUES ('Northeast Corridor'), ('Northeast Corridor'),
       ('Central Jersey Transit'), ('Central Jersey Transit');



-- Insert sample schedules into the Schedules table
INSERT INTO Schedules (schedule_id, train_id, departure_time, arrival_time, direction)
VALUES (1, 1000, '08:00:00', '10:30:00', 'Forward'),
       (2, 1001, '11:00:00', '13:30:00', 'Reverse'),
       (3, 1002, '09:00:00', '09:45:00', 'Forward'),
       (4, 1003, '10:15:00', '11:00:00', 'Reverse');


-- Insert stops for Schedule 1 (Train 1000 on Northeast Corridor)
-- Forward Schedule
INSERT INTO TrainStops (schedule_id, station_id, arrival_time, departure_time, stop_number)
VALUES
    (1, 8, NULL, '08:00:00', 1),  -- Origin
    (1, 2, '08:15:00', '08:20:00', 2),
    (1, 1, '08:35:00', '08:40:00', 3),
    (1, 6, '09:10:00', '09:15:00', 4),
    (1, 4, '09:40:00', '09:45:00', 5),
    (1, 5, '10:30:00', NULL, 6);  -- Destination


-- Reverse Schedule
INSERT INTO TrainStops (schedule_id, station_id, arrival_time, departure_time, stop_number)
VALUES
    (2, 5, NULL, '11:00:00', 1),  -- Origin
    (2, 4, '11:45:00', '11:50:00', 2),
    (2, 6, '12:15:00', '12:20:00', 3),
    (2, 1, '12:50:00', '12:55:00', 4),
    (2, 2, '13:10:00', '13:15:00', 5),
    (2, 8, '13:30:00', NULL, 6);  -- Destination


-- Forward Schedule
INSERT INTO TrainStops (schedule_id, station_id, arrival_time, departure_time, stop_number)
VALUES
    (3, 6, NULL, '09:00:00', 1),  -- Origin
    (3, 8, '09:45:00', NULL, 2);  -- Destination


-- Reverse Schedule
INSERT INTO TrainStops (schedule_id, station_id, arrival_time, departure_time, stop_number)
VALUES
    (4, 8, NULL, '10:15:00', 1),  -- Origin
    (4, 6, '11:00:00', NULL, 2);  -- Destination





SELECT * FROM Reservations;

UPDATE Users SET role = 'ADMIN' WHERE username = 'customer1';




