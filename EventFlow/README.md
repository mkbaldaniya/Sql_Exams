# 🎟️ EventFlow SQL – Smart Event & Ticket Management System

![MySQL](https://img.shields.io/badge/Database-MySQL-blue?style=for-the-badge&logo=mysql)
![SQL](https://img.shields.io/badge/Language-SQL-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Project-Completed-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## 📌 Overview

**EventFlow SQL** is a complete relational database project developed using **MySQL** to manage events, ticket bookings, attendees, organizers, venues, and payments.

The project demonstrates advanced SQL concepts including:

- Database Design
- Relationships
- CRUD Operations
- Complex Queries
- Joins
- Aggregate Functions
- Window Functions
- CASE Statements
- Subqueries
- Business Insights

This project is designed to simulate a real-world Event Management platform where organizers can create events, users can book tickets, and payments are tracked efficiently.

---

# 🎯 Objectives

- Build a normalized relational database
- Manage event bookings
- Track ticket availability
- Monitor payment status
- Generate revenue reports
- Practice advanced SQL concepts
- Perform business analytics using SQL

---

# 🗄️ Database Schema

The database contains **6 relational tables**.

| Table | Description |
|--------|-------------|
| Organizers | Stores organizer details |
| Venues | Stores venue information |
| Events | Stores event details |
| Attendees | Stores attendee records |
| Tickets | Stores booking information |
| Payments | Stores payment records |

---

# 🔗 Entity Relationship

```
Organizers
      │
      │
      ▼
    Events
      │
 ┌────┴────┐
 ▼         ▼
Venues   Tickets
            │
     ┌──────┴──────┐
     ▼             ▼
Attendees      Payments
```

---

# 📚 Database Features

✅ Relational Database Design

✅ Primary Keys

✅ Foreign Keys

✅ Auto Increment IDs

✅ Data Integrity

✅ Unique Constraints

✅ ENUM Data Types

✅ Default Values

---

# 📥 Sample Data

The project includes sample records for:

- Organizers
- Venues
- Events
- Attendees
- Tickets
- Payments

making it ready to execute immediately after importing.

---

# ⚙️ CRUD Operations

### Create

```sql
INSERT INTO Events (...)
```

### Read

```sql
SELECT * FROM Events;
```

### Update

```sql
UPDATE Events
SET ticket_price = 1800
WHERE event_id = 1;
```

### Delete

```sql
DELETE FROM Attendees
WHERE attendee_id = 3;
```

---

# 🔍 SQL Concepts Covered

## Basic Queries

- SELECT
- INSERT
- UPDATE
- DELETE

---

## Joins

✔ INNER JOIN

✔ LEFT JOIN

✔ RIGHT JOIN

✔ FULL OUTER JOIN (using UNION)

---

## Aggregate Functions

- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()

---

## Date Functions

- NOW()
- CURDATE()
- MONTH()
- DATEDIFF()
- DATE_FORMAT()

---

## String Functions

- UPPER()
- TRIM()
- IFNULL()

---

## Subqueries

Examples include:

- Revenue above average
- Multiple event attendees
- Organizers managing multiple events

---

## Window Functions

- RANK()
- SUM() OVER()
- PARTITION BY

---

## CASE Statements

Used for:

- Demand Classification
- Payment Status Classification

---

# 📈 Business Analytics Queries

The project generates useful business insights such as:

### 📅 Upcoming Events

Find all upcoming events by location.

---

### 💰 Top Revenue Events

Identify highest earning events.

---

### 🎫 Total Revenue

Calculate overall successful payment revenue.

---

### 👥 Event Attendance

Count attendees per event.

---

### 📊 Event Demand

Categorize events into:

- High Demand
- Moderate Demand
- Low Demand

---

### 💳 Payment Analysis

Track

- Successful Payments
- Failed Payments
- Pending Payments

---

### 📆 Upcoming Days Remaining

Calculate remaining days before every event.

---

### 🎯 Most Popular Event

Find event with maximum attendees.

---

### 💹 Running Revenue

Calculate cumulative revenue over time.

---

# 📂 Project Structure

```
EventFlow-SQL/
│
├── Database.sql
├── README.md
└── Screenshots/
```

---

# 🛠 Technologies Used

- MySQL
- SQL
- MySQL Workbench

---

# 🎓 SQL Skills Demonstrated

✔ Database Design

✔ Data Modeling

✔ Table Relationships

✔ CRUD Operations

✔ Joins

✔ Aggregate Functions

✔ Window Functions

✔ CASE Statements

✔ Subqueries

✔ Business Reporting

✔ Data Analysis

✔ Performance Friendly Queries

---

# 🚀 Future Improvements

- Stored Procedures
- Triggers
- Views
- Transactions
- Index Optimization
- User Authentication
- Role-Based Access Control
- Dashboard Integration (Power BI)
- REST API Integration
- Event Recommendation Engine

---

# 📊 Learning Outcomes

This project demonstrates practical experience in:

- Designing normalized relational databases
- Writing optimized SQL queries
- Solving real-world business problems
- Generating analytical reports
- Managing event booking systems

---

# ⭐ Author

**Maulik Baldaniya**

Aspiring Data Analyst | SQL | Python | Power BI | Excel

GitHub: https://github.com/mkbaldaniya

---

## 🌟 If you found this project useful,

Give it a ⭐ on GitHub!
