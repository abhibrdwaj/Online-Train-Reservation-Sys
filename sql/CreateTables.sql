
CREATE DATABASE RailwayBookingSystem;
USE RailwayBookingSystem;

CREATE TABLE train (
    train_number INT AUTO_INCREMENT PRIMARY KEY,
    train_name VARCHAR(255)
)AUTO_INCREMENT = 3000;

CREATE TABLE station (
    station_id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL
);

CREATE TABLE transit_line (
    -- line_id INT PRIMARY KEY AUTO_INCREMENT,
    line_name VARCHAR(255)  PRIMARY KEY,
    origin_station_id INT,
    destination_station_id INT,
    FOREIGN KEY (origin_station_id) REFERENCES station(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES station(station_id)
);

CREATE TABLE schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    line_id INT,
    train_id CHAR(4),
    departure_datetime DATETIME NOT NULL,
    arrival_datetime DATETIME NOT NULL,
    travel_time INT NOT NULL,
    fare DECIMAL(10, 2) NOT NULL,
    stops TEXT,
    FOREIGN KEY (line_id) REFERENCES transit_line(line_id),
    FOREIGN KEY (train_id) REFERENCES train(train_number)
);

CREATE TABLE stop (
    stop_id INT PRIMARY KEY AUTO_INCREMENT,
    schedule_id INT NOT NULL,
    station_id INT NOT NULL,
    stop_number INT NOT NULL,
    arrival_datetime DATETIME NOT NULL,
    departure_datetime DATETIME NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES Schedule(schedule_id),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

CREATE TABLE customer (
    -- customer_id INT PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE reservation (
    reservation_no INT AUTO_INCREMENT PRIMARY KEY,
    reservation_date DATE NOT NULL,
    total_fare DECIMAL(10, 2) NOT NULL,
    customer_id INT NOT NULL,
    schedule_id INT NOT NULL,
    from_station_id INT NOT NULL,
    to_station_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (schedule_id) REFERENCES Schedule(schedule_id),
    FOREIGN KEY (from_station_id) REFERENCES station(station_id),
    FOREIGN KEY (to_station_id) REFERENCES station(station_id)
);


CREATE TABLE employee (
    ssn CHAR(9) UNIQUE NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin/Manager', 'Customer Representative') NOT NULL
);

ALTER TABLE Schedule 
    ADD UNIQUE INDEX (train_id, departure_datetime, arrival_datetime);

ALTER TABLE Stop 
    ADD UNIQUE INDEX (schedule_id, station_id, stop_number);
