-- Create database
CREATE DATABASE SpaceTourism;
USE SpaceTourism;

-- Passengers
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50),
    age INT,
    membership_level VARCHAR(20) -- Silver, Gold, Platinum
);

-- Spacecrafts
CREATE TABLE Spacecrafts (
    craft_id INT PRIMARY KEY,
    craft_name VARCHAR(50),
    capacity INT,
    manufacturer VARCHAR(50)
);

-- Flights
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    craft_id INT,
    destination VARCHAR(50),
    launch_date DATE,
    duration_days INT,
    ticket_price DECIMAL(10,2),
    FOREIGN KEY (craft_id) REFERENCES Spacecrafts(craft_id)
);

-- Bookings
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    booking_date DATE,
    seat_class VARCHAR(20), -- Economy, Business, Luxury
    amount_paid DECIMAL(10,2),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);


-- Passengers
INSERT INTO Passengers VALUES
(1, 'Alice', 'USA', 34, 'Gold'),
(2, 'Raj', 'India', 29, 'Silver'),
(3, 'Mei', 'China', 41, 'Platinum'),
(4, 'Carlos', 'Brazil', 38, 'Gold'),
(5, 'Fatima', 'UAE', 27, 'Silver'),
(6, 'Elena', 'Russia', 45, 'Platinum'),
(7, 'John', 'USA', 52, 'Gold');

-- Spacecrafts
INSERT INTO Spacecrafts VALUES
(1, 'StarVoyager', 50, 'SpaceX'),
(2, 'LunarCruiser', 30, 'Blue Origin'),
(3, 'CosmosX', 20, 'Virgin Galactic');

-- Flights
INSERT INTO Flights VALUES
(101, 1, 'Moon', '2025-06-15', 7, 500000),
(102, 2, 'Mars Orbit', '2025-09-20', 30, 2000000),
(103, 1, 'Space Station', '2025-08-01', 10, 300000),
(104, 3, 'Moon', '2025-10-12', 8, 450000),
(105, 2, 'Asteroid Belt', '2026-01-05', 60, 5000000);

-- Bookings
INSERT INTO Bookings VALUES
(201, 1, 101, '2025-05-01', 'Luxury', 500000),
(202, 2, 101, '2025-05-05', 'Economy', 300000),
(203, 3, 102, '2025-07-01', 'Business', 2000000),
(204, 4, 103, '2025-07-10', 'Economy', 300000),
(205, 5, 104, '2025-09-01', 'Luxury', 450000),
(206, 6, 105, '2025-10-15', 'Business', 5000000),
(207, 7, 101, '2025-05-07', 'Business', 500000);


select * from bookings;
select * from flights;
select * from passengers;
select * from spacecrafts;



-- Find the total number of passengers.
select count(*) as total from passengers;

-- Count passengers grouped by country.
select country ,count(*) as total from passengers group by country;


-- Find the average age of all passengers.
select avg(age) from  passengers;

-- Show the youngest and oldest passengers' age.
select min(age) as youngest  , max(age) as oldest from passengers; 
-- subquries


-- Find membership levels that have more than 2 passengers.
select membership_level, count(*) as member_count from passengers group by membership_level having member_count >2;

-- Rank passengers by age.
select age , rank () over(order by age) as  ranking_age from passengers;

-- Rank passengers by age within their country.
select   country ,age , rank () over (partition by country order by age) as  ranking_age from passengers;


-- Show the minimum and maximum flight duration per destination.
select destination, min(duration_days) as min_duration , max(duration_days) as max_duration  from flights group by destination;

-- Find destinations where the average duration is > 10 days.
select destination ,round(avg(duration_days)) as average from flights group by destination having average>10;


-- Calculate the rank of flights by ticket_price (highest first).
select destination,ticket_price, rank() over(order by ticket_price desc) as ticket_rank from flights;


-- Show a running total of ticket_price ordered by launch_date.
select ticket_price, sum(ticket_price) over (order by launch_date) from flights;

-- Find the average amount paid per seat class.
select seat_class , round(avg(amount_paid)) from bookings group by seat_class;

-- Find the number of unique destinations.
select count(distinct(destination)) as unique_dest from flights;


-- Show the top 3 oldest passengers.
select * from passengers order by age desc limit 3;

-- List countries with the average passenger age below 30.
select country , avg(age) as avg_age from passengers group by country having avg_age < 30;

-- Find the difference between the highest and lowest ticket_price.
select max(ticket_price) as max, min(ticket_price)as min, (max(ticket_price)-min(ticket_price)) as difference from flights ;

