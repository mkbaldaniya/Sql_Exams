
CREATE DATABASE SEMS;
USE SEMS;

-- Table 1 ---------------------------------------------------------------------------------
CREATE TABLE Organizers (
    organizer_id INT PRIMARY KEY AUTO_INCREMENT,
    organizer_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(150),
    phone_number VARCHAR(20)
);

-- Table 2 ---------------------------------------------------------------------------------
CREATE TABLE Venues (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    capacity INT NOT NULL
);
-- Table 3 ---------------------------------------------------------------------------------
CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    venue_id INT,
    organizer_id INT,
    ticket_price DECIMAL(10,2),
    total_seats INT,
    available_seats INT,
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
);

-- Table 4 ---------------------------------------------------------------------------------
CREATE TABLE Attendees (
    attendee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    phone_number VARCHAR(20)
);

-- Table 5 ---------------------------------------------------------------------------------
CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    attendee_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Confirmed','Cancelled','Pending') DEFAULT 'Pending',
    UNIQUE(event_id, attendee_id), -- Prevent duplicate booking
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id)
);
-- Table 6 ---------------------------------------------------------------------------------
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    amount_paid DECIMAL(10,2),
    payment_status ENUM('Success','Failed','Pending'),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);
-- Insert Data -------------------------------------------------------------------------------
INSERT INTO Organizers (organizer_name, contact_email, phone_number) VALUES
('Tech World','tech@event.com','9876543210'),
('Music Fest Org','music@event.com','9123456780');

INSERT INTO Venues (venue_name, location, capacity) VALUES
('Surat Convention Hall','Surat',500),
('Ahmedabad Arena','Ahmedabad',1000);

INSERT INTO Events (event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats) VALUES
('AI Conference','2025-12-15',1,1,1500,500,200),
('Rock Concert','2025-11-20',2,2,2500,1000,100),
('Startup Meetup','2025-12-05',1,1,800,300,150);

INSERT INTO Attendees (name,email,phone_number) VALUES
('Rahul','rahul@gmail.com','9991112222'),
('Priya','priya@gmail.com','8881112222'),
('Amit','amit@gmail.com','7771112222');

INSERT INTO Tickets (event_id,attendee_id,status) VALUES
(1,1,'Confirmed'),
(1,2,'Pending'),
(2,1,'Confirmed'),
(3,3,'Confirmed');

INSERT INTO Payments (ticket_id,amount_paid,payment_status) VALUES
(1,1500,'Success'),
(2,1500,'Pending'),
(3,2500,'Success'),
(4,800,'Success');


-- UPDATE --------------------------------------------------------------------------------------------------------------------------
UPDATE Events SET ticket_price = 1800 WHERE event_id = 1;

-- DELETE --------------------------------------------------------------------------------------------------------------------------
DELETE FROM Attendees WHERE attendee_id = 3;

-- SELECT --------------------------------------------------------------------------------------------------------------------------
SELECT * FROM Events;

-- Upcoming events in Surat----------------------------------------------------------------------------------------------------------
SELECT * FROM Events e
INNER JOIN Venues v ON e.venue_id = v.venue_id WHERE v.location = 'Surat';

-- Top 5 highest revenue events--------------------------------------------------------------------------------------------------------
SELECT e.event_name, SUM(p.amount_paid) AS total_revenue FROM Events e
INNER JOIN Tickets t ON e.event_id = t.event_id
INNER JOIN Payments p ON t.ticket_id = p.ticket_id
WHERE p.payment_status='Success' GROUP BY e.event_id ORDER BY total_revenue DESC LIMIT 5;

-- Attendees booked in last 7 days--------------------------------------------------------------------------------------------------------
SELECT DISTINCT a.*
FROM Attendees a
INNER JOIN Tickets t ON a.attendee_id=t.attendee_id
WHERE t.booking_date >= NOW() - INTERVAL 7 DAY;

-- December events with >50% available seats
SELECT * FROM Events WHERE MONTH(event_date)=12 AND available_seats > total_seats*0.5;

-- Ticket OR pending payment
SELECT DISTINCT a.* FROM Attendees a LEFT JOIN Tickets t ON a.attendee_id=t.attendee_id
LEFT JOIN Payments p ON t.ticket_id=p.ticket_id WHERE t.ticket_id IS NOT NULL OR p.payment_status='Pending';

-- Fully booked events
SELECT * FROM Events WHERE available_seats=0;

-- Sort by date
SELECT * FROM Events ORDER BY event_date ASC;

-- Count attendees per event
SELECT e.event_name, COUNT(t.ticket_id) AS total_attendees
FROM Events e
LEFT JOIN Tickets t ON e.event_id=t.event_id
GROUP BY e.event_id;

-- Revenue per event
SELECT e.event_name, SUM(p.amount_paid) AS revenue
FROM Events e
INNER JOIN Tickets t ON e.event_id=t.event_id
INNER JOIN Payments p ON t.ticket_id=p.ticket_id
WHERE p.payment_status='Success'
GROUP BY e.event_id;

SELECT SUM(amount_paid) AS total_revenue FROM Payments WHERE payment_status='Success';

SELECT e.event_name, COUNT(t.ticket_id) AS attendees
FROM Events e
JOIN Tickets t ON e.event_id=t.event_id
GROUP BY e.event_id
ORDER BY attendees DESC LIMIT 1;

SELECT AVG(ticket_price) AS avg_ticket_price FROM Events;


-- INNER JOIN
SELECT e.event_name,v.venue_name
FROM Events e
INNER JOIN Venues v ON e.venue_id=v.venue_id;

-- LEFT JOIN
SELECT a.name
FROM Attendees a
LEFT JOIN Tickets t ON a.attendee_id=t.attendee_id
LEFT JOIN Payments p ON t.ticket_id=p.ticket_id
WHERE p.payment_status IS NULL;

-- RIGHT JOIN
SELECT e.event_name
FROM Tickets t
RIGHT JOIN Events e ON t.event_id=e.event_id
WHERE t.ticket_id IS NULL;

-- FULL OUTER JOIN 
SELECT a.name
FROM Attendees a
LEFT JOIN Tickets t ON a.attendee_id=t.attendee_id
UNION
SELECT a.name
FROM Attendees a
RIGHT JOIN Tickets t ON a.attendee_id=t.attendee_id;

-- Revenue above average
SELECT event_name
FROM Events
WHERE event_id IN (
    SELECT e.event_id
    FROM Events e
    JOIN Tickets t ON e.event_id=t.event_id
    JOIN Payments p ON t.ticket_id=p.ticket_id
    WHERE p.payment_status='Success'
    GROUP BY e.event_id
    HAVING SUM(p.amount_paid) >
    (SELECT AVG(amount_paid) FROM Payments WHERE payment_status='Success')
);

-- Multiple events attendees
SELECT attendee_id
FROM Tickets
GROUP BY attendee_id
HAVING COUNT(event_id)>1;

-- Organizers managing >1 event
SELECT organizer_id
FROM Events
GROUP BY organizer_id
HAVING COUNT(event_id)>1;

SELECT MONTH(event_date) AS event_month FROM Events;

SELECT event_name, DATEDIFF(event_date,CURDATE()) AS days_remaining
FROM Events;

SELECT DATE_FORMAT(payment_date,'%Y-%m-%d %H:%i:%s') FROM Payments;


SELECT UPPER(organizer_name) FROM Organizers;

SELECT TRIM(name) FROM Attendees;

SELECT IFNULL(email,'Not Provided') FROM Attendees;



-- Rank events by revenue
SELECT event_name,
RANK() OVER (ORDER BY SUM(amount_paid) DESC) AS rank_position
FROM Events e
JOIN Tickets t ON e.event_id=t.event_id
JOIN Payments p ON t.ticket_id=p.ticket_id
WHERE p.payment_status='Success'
GROUP BY e.event_id;

-- Cumulative sales
SELECT payment_date,
SUM(amount_paid) OVER (ORDER BY payment_date) AS cumulative_sales
FROM Payments
WHERE payment_status='Success';

-- Running total per event
SELECT e.event_name,
SUM(p.amount_paid) OVER (PARTITION BY e.event_id ORDER BY p.payment_date) AS running_total
FROM Events e
JOIN Tickets t ON e.event_id=t.event_id
JOIN Payments p ON t.ticket_id=p.ticket_id;


SELECT event_name,
CASE
    WHEN available_seats < total_seats*0.2 THEN 'High Demand'
    WHEN available_seats BETWEEN total_seats*0.2 AND total_seats*0.5 THEN 'Moderate Demand'
    ELSE 'Low Demand'
END AS demand_category
FROM Events;

SELECT payment_id,
CASE
    WHEN payment_status='Success' THEN 'Success'
    WHEN payment_status='Failed' THEN 'Failed'
    ELSE 'Pending'
END AS payment_state
FROM Payments;
