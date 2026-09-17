-- =====================================================
-- E-COMMERCE SALES & CUSTOMER ANALYSIS USING SQL
-- =====================================================

USE ecommerce_analysis;
-- =====================================================
-- 1. DATA QUALITY CHECKS
-- =====================================================

-- Check number of customers
SELECT COUNT(*) AS total_customers
FROM olist_customers_dataset;

-- Check number of orders
SELECT COUNT(*) AS total_orders
FROM olist_orders_dataset;
-- Check for missing values in customer data

SELECT
    COUNT(*) AS total_rows,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(customer_unique_id IS NULL) AS missing_customer_unique_id,
    SUM(customer_zip_code_prefix IS NULL) AS missing_zip_code,
    SUM(customer_city IS NULL) AS missing_city,
    SUM(customer_state IS NULL) AS missing_state
FROM olist_customers_dataset;
-- Check for missing values in order data

SELECT
    COUNT(*) AS total_rows,
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(order_status IS NULL) AS missing_order_status,
    SUM(order_purchase_timestamp IS NULL) AS missing_purchase_date
FROM olist_orders_dataset;
-- =====================================================
-- 2. ORDER STATUS ANALYSIS
-- =====================================================

-- Count orders by status

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;


-- Calculate percentage of each order status

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM olist_orders_dataset),
        2
    ) AS percentage
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY percentage DESC;


-- Classify orders as completed or not completed

SELECT
    CASE
        WHEN order_status = 'delivered' THEN 'Completed'
        ELSE 'Not Completed'
    END AS order_category,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM olist_orders_dataset),
        2
    ) AS percentage
FROM olist_orders_dataset
GROUP BY
    CASE
        WHEN order_status = 'delivered' THEN 'Completed'
        ELSE 'Not Completed'
    END
ORDER BY total_orders DESC;


-- Analyze non-delivered orders

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
WHERE order_status <> 'delivered'
GROUP BY order_status
ORDER BY total_orders DESC;
-- =====================================================
-- 3. CUSTOMER LOCATION ANALYSIS
-- =====================================================

-- Customers by state

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY total_customers DESC;


-- Top 10 cities by number of customers

SELECT
    customer_city,
    COUNT(*) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;
-- =====================================================
-- 4. TIME-BASED ORDER ANALYSIS
-- =====================================================

-- Orders by month

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- Orders by day of the week

SELECT
    DAYNAME(order_purchase_timestamp) AS day_of_week,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY DAYNAME(order_purchase_timestamp)
ORDER BY total_orders DESC;


-- Orders by hour

SELECT
    HOUR(order_purchase_timestamp) AS order_hour,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY HOUR(order_purchase_timestamp)
ORDER BY total_orders DESC;


-- Orders by time of day

SELECT
    CASE
        WHEN HOUR(order_purchase_timestamp) BETWEEN 0 AND 5
            THEN 'Night'
        WHEN HOUR(order_purchase_timestamp) BETWEEN 6 AND 11
            THEN 'Morning'
        WHEN HOUR(order_purchase_timestamp) BETWEEN 12 AND 17
            THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_period,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY
    CASE
        WHEN HOUR(order_purchase_timestamp) BETWEEN 0 AND 5
            THEN 'Night'
        WHEN HOUR(order_purchase_timestamp) BETWEEN 6 AND 11
            THEN 'Morning'
        WHEN HOUR(order_purchase_timestamp) BETWEEN 12 AND 17
            THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY total_orders DESC;
-- =====================================================
-- 5. CUSTOMER-ORDER ANALYSIS USING JOINS
-- =====================================================

-- Orders by customer state

SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM olist_customers_dataset AS c
INNER JOIN olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;


-- Customers and orders by state

SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(o.order_id) AS total_orders
FROM olist_customers_dataset AS c
INNER JOIN olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;


-- Orders per customer by state

SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(o.order_id) AS total_orders,
    ROUND(
        COUNT(o.order_id) * 1.0 /
        COUNT(DISTINCT c.customer_id),
        2
    ) AS orders_per_customer
FROM olist_customers_dataset AS c
INNER JOIN olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY orders_per_customer DESC;


-- Customers without a matching order
-- Note: This refers only to the imported order data.

SELECT
    COUNT(*) AS customers_without_orders
FROM olist_customers_dataset AS c
LEFT JOIN olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Customers with and without matching orders

SELECT
    CASE
        WHEN o.order_id IS NULL
            THEN 'No Matching Order'
        ELSE 'Has Matching Order'
    END AS order_status,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM olist_customers_dataset),
        2
    ) AS percentage
FROM olist_customers_dataset AS c
LEFT JOIN olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
GROUP BY
    CASE
        WHEN o.order_id IS NULL
            THEN 'No Matching Order'
        ELSE 'Has Matching Order'
    END
ORDER BY total_customers DESC;
-- =====================================================
-- 6. LOCATION-BASED ORDER ANALYSIS
-- =====================================================

-- Top 10 states by order volume

SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM olist_customers_dataset AS c
INNER JOIN olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC
LIMIT 10;


-- Top 10 cities by order volume

SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM olist_customers_dataset AS c
INNER JOIN olist_orders_dataset AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;
-- =====================================================
-- 7. KEY PROJECT INSIGHTS
-- =====================================================

-- Dataset overview:
-- Customer records: 99,441
-- Imported order records: 3,625

-- Order performance:
-- Delivered orders: 3,526 (97.27%)
-- Non-delivered orders: 99 (2.73%)

-- Customer location:
-- SP had the highest number of customers.
-- SP also had the highest number of orders.

-- City analysis:
-- Sao Paulo had the highest order volume among cities.

-- Time analysis:
-- Afternoon had the highest number of orders.
-- 1 PM was the peak individual order hour.

-- Important data limitation:
-- The imported orders dataset contains only 3,625 order records.
-- Therefore, customers without matching orders should not be
-- interpreted as customers who never placed an order.
-- They simply have no matching order record in the imported
-- order subset.

-- Project conclusion:
-- SQL was used to analyze customer distribution,
-- order status, order timing, geographic order patterns,
-- and customer-order relationships.