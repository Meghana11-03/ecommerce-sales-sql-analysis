# E-Commerce Sales & Customer Analysis Using SQL

## 📌 Project Overview

This project analyzes e-commerce customer and order data using SQL.

The analysis focuses on customer distribution, order status, order trends, order timing, geographic patterns, and customer-order relationships.

The project was developed using MySQL Workbench.

## 🎯 Project Objective

The main objective of this project is to use SQL queries to extract meaningful insights from e-commerce data and demonstrate practical SQL and data analysis skills.

## 🗂️ Dataset

The project uses e-commerce customer and order data from the Olist dataset.

The analysis uses two tables:

### 1. `olist_customers_dataset`

Contains customer-related information such as:

* Customer ID
* Customer unique ID
* Customer ZIP code
* Customer city
* Customer state

### 2. `olist_orders_dataset`

Contains order-related information such as:

* Order ID
* Customer ID
* Order status
* Order purchase timestamp

### Dataset Size Used

* Customer records: **99,441**
* Imported order records: **3,625**

## 🛠️ Tools & Technologies

* MySQL
* MySQL Workbench
* SQL
* GitHub

## 💻 SQL Concepts Used

The project demonstrates:

* SELECT
* WHERE
* GROUP BY
* ORDER BY
* LIMIT
* COUNT()
* COUNT(DISTINCT)
* ROUND()
* CASE statements
* Subqueries
* INNER JOIN
* LEFT JOIN
* HAVING
* DATE_FORMAT()
* DAYNAME()
* HOUR()

## 📊 Analysis Performed

### 1. Data Quality Analysis

Checked:

* Total number of customer records
* Total number of order records
* Missing values in customer data
* Missing values in order data

### 2. Order Status Analysis

Analyzed:

* Orders by status
* Percentage of each order status
* Completed vs. non-completed orders
* Non-delivered orders

### 3. Customer Location Analysis

Analyzed:

* Customers by state
* Top 10 cities by number of customers

### 4. Time-Based Analysis

Analyzed:

* Monthly order trends
* Orders by day of the week
* Orders by hour
* Orders by time of day

### 5. Customer-Order Analysis

Used SQL JOINs to analyze:

* Orders by customer state
* Customers and orders by state
* Orders per customer by state
* Customers with and without matching order records

### 6. Location-Based Order Analysis

Identified:

* Top 10 states by order volume
* Top 10 cities by order volume

## 🔍 Key Findings

* **3,526 orders (97.27%)** in the imported order data were delivered.
* **99 orders (2.73%)** were not delivered.
* **São Paulo (SP)** had the highest order volume among the states in the analyzed data.
* **São Paulo city** had the highest order volume among the analyzed cities.
* **Afternoon** had the highest number of orders among the defined time periods.
* **1 PM** was the peak individual order hour in the analyzed order data.

## ⚠️ Data Limitation

The customer table contains **99,441 records**, while the imported order table contains only **3,625 records**.

Therefore, customers identified as having **"No Matching Order"** should not be interpreted as customers who never placed an order. They simply do not have a matching order record in the imported order subset used for this project.

## 📁 Project Structure

```text
ecommerce-sales-sql-analysis/
│
├── ecommerce_analysis.sql
├── README.md
│
└── screenshots/
```

## ▶️ How to Run the Project

1. Install MySQL and MySQL Workbench.
2. Create a database named `ecommerce_analysis`.
3. Import the required Olist customer and order data.
4. Open `ecommerce_analysis.sql` in MySQL Workbench.
5. Execute the SQL queries section by section.
6. Review the query results.

## 👩‍💻 Author

**Meghana**

This project was created as a SQL-based data analysis project for learning and portfolio development.
