/*
=======================================================
NORTHWIND TRADERS SALES & CUSTOMER ANALYSIS
=======================================================

Analyst: Tamera Johnson

Project Purpose:
Analyze Northwind Traders customer, order, product,
employee, geographic, and sales data using SQL to identify
revenue patterns, customer behavior, product performance,
sales trends, and potential data-quality issues.

Key SQL Skills Demonstrated:
- SELECT and filtering
- Aggregate functions
- GROUP BY and ORDER BY
- Multi-table JOINs
- Calculated fields
- CASE WHEN
- Subqueries
- Date analysis
- NULL handling
- LEFT JOIN
- Data-quality validation

Database:
Northwind Traders

Tables Analyzed:
- customers
- orders
- order_details
- products
- categories
- employees
- shippers
=======================================================
*/

-- ====================================================
-- 1. DATA EXPLORATION
-- ====================================================

-- Preview customer data

SELECT *
FROM customers
LIMIT 10;

-- Orders

SELECT *
FROM orders
LIMIT 10;

-- Preview order detail data

SELECT *
FROM order_details
LIMIT 10;

-- Preview product data

SELECT *
FROM products
LIMIT 10;

-- Preview employee data

SELECT *
FROM employees
LIMIT 10;

-- Preview shipper data

SELECT *
FROM shippers
LIMIT 10;

-- Count total customers

SELECT COUNT(*) AS total_customers
FROM customers;

-- Count total orders

SELECT COUNT(*) AS total_orders
FROM orders;

-- Count total order detail records

SELECT COUNT(*) AS order_details
FROM order_details;

-- Count total products

SELECT COUNT(*) AS total_products
FROM products;

-- Count total categories

SELECT COUNT(*) AS total_categories
FROM categories;

-- Count total employees

SELECT COUNT(*) AS total_employees
FROM employees;

-- Count total shippers

SELECT COUNT(*) AS total_shippers
FROM shippers;

-- ============================================
-- 2. CUSTOMER ANALYSIS
-- ============================================

-- View customer names and locations

SELECT customerID,
       companyName,
       city,
       country
FROM customers;

-- Find customers located in the USA

SELECT customerID,
       companyName,
       city,
       country
FROM customers
WHERE country = 'USA';

-- Find customers located in the USA or Canada

SELECT customerID,
       companyName,
       city,
       country
FROM customers
WHERE country = 'USA'
   OR country = 'Canada';
   
-- Find customers in selected countries

SELECT customerID,
       companyName,
       country
FROM customers
WHERE country IN ('USA', 'Canada', 'Mexico');

-- Count customers by country

SELECT country,
       COUNT(*) AS customer_count
FROM customers
GROUP BY country
ORDER BY customer_count DESC;

-- ============================================
-- 3. PRODUCT ANALYSIS
-- ============================================

-- View product names and prices

SELECT productName,
       unitPrice
FROM products;

-- Sort products from highest to lowest price

SELECT productName,
       unitPrice
FROM products
ORDER BY unitPrice DESC;

-- Sort products from lowest to highest price

SELECT productName,
       unitPrice
FROM products
ORDER BY unitPrice ASC;

-- Find the 10 most expensive products

SELECT productName,
       unitPrice
FROM products
ORDER BY unitPrice DESC
LIMIT 10;

-- Calculate the average product price

SELECT AVG(unitPrice) AS average_product_price
FROM products;

-- Find the highest product price

SELECT MAX(unitPrice) AS highest_product_price
FROM products;

-- Find the lowest product price

SELECT MIN(unitPrice) AS lowest_product_price
FROM products;

-- Summarize product prices

SELECT AVG(unitPrice) AS average_price,
       MIN(unitPrice) AS lowest_price,
       MAX(unitPrice) AS highest_price
FROM products;

-- ============================================
-- 4. SALES ANALYSIS
-- ============================================

-- Review the fields needed for sales calculations

SELECT orderID,
       productID,
       unitPrice,
       quantity,
       discount
FROM order_details
LIMIT 10;

-- Calculate gross sales for each order detail

SELECT orderID,
       productID,
       unitPrice,
       quantity,
       unitPrice * quantity AS gross_sales
FROM order_details
LIMIT 10;

-- Calculate revenue after discounts

SELECT orderID,
       productID,
       unitPrice,
       quantity,
       discount,
       unitPrice * quantity * (1 - discount) AS revenue
FROM order_details
LIMIT 10;

-- Calculate total sales revenue

SELECT SUM(unitPrice * quantity * (1 - discount)) AS total_revenue
FROM order_details;

-- ============================================
-- 5. JOIN ANALYSIS
-- ============================================

-- Review the common product ID in both tables

SELECT productID
FROM order_details
LIMIT 10;

SELECT productID,
       productName
FROM products
LIMIT 10;

-- Match order details with product names

SELECT products.productName,
       order_details.quantity,
       order_details.unitPrice
FROM order_details
JOIN products
    ON order_details.productID = products.productID
LIMIT 10;

-- Repeat the product JOIN using table aliases

SELECT p.productName,
       od.quantity,
       od.unitPrice
FROM order_details AS od
JOIN products AS p
    ON od.productID = p.productID
LIMIT 10;

-- Calculate revenue while displaying product names

SELECT p.productName,
       od.quantity,
       od.unitPrice,
       od.discount,
       od.unitPrice * od.quantity * (1 - od.discount) AS revenue
FROM order_details AS od
JOIN products AS p
    ON od.productID = p.productID
LIMIT 10;

-- Calculate total revenue by product

SELECT p.productName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM order_details AS od
JOIN products AS p
    ON od.productID = p.productID
GROUP BY p.productName
ORDER BY total_revenue DESC;

-- Find the 10 highest-revenue products

SELECT p.productName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM order_details AS od
JOIN products AS p
    ON od.productID = p.productID
GROUP BY p.productName
ORDER BY total_revenue DESC
LIMIT 10;

-- Review the customer-to-order relationship

SELECT customerID,
       companyName
FROM customers
LIMIT 10;

SELECT orderID,
       customerID
FROM orders
LIMIT 10;

SELECT orderID,
       productID
FROM order_details
LIMIT 10;

-- Connect customers, orders, and order details

SELECT c.companyName,
       o.orderID,
       od.productID,
       od.quantity
FROM customers AS c
JOIN orders AS o
    ON c.customerID = o.customerID
JOIN order_details AS od
    ON o.orderID = od.orderID
LIMIT 20;

-- Calculate total revenue by customer

SELECT c.companyName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customerID = o.customerID
JOIN order_details AS od
    ON o.orderID = od.orderID
GROUP BY c.companyName
ORDER BY total_revenue DESC;

-- Find the 10 highest-revenue customers

SELECT c.companyName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customerID = o.customerID
JOIN order_details AS od
    ON o.orderID = od.orderID
GROUP BY c.companyName
ORDER BY total_revenue DESC
LIMIT 10;

-- ============================================
-- 6. CATEGORY ANALYSIS
-- ============================================

-- Review the category-to-product relationship

SELECT categoryID,
       categoryName
FROM categories;

SELECT productID,
       productName,
       categoryID
FROM products
LIMIT 10;

-- Calculate total revenue by category

SELECT c.categoryName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM categories AS c
JOIN products AS p
    ON c.categoryID = p.categoryID
JOIN order_details AS od
    ON p.productID = od.productID
GROUP BY c.categoryName
ORDER BY total_revenue DESC;

-- ============================================
-- 7. EMPLOYEE ANALYSIS
-- ============================================

-- Review the employee-to-order relationship

SELECT employeeID,
       employeeName,
       title
FROM employees;

SELECT orderID,
       employeeID
FROM orders
LIMIT 10;

-- Calculate revenue associated with each employee

SELECT e.employeeName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM employees AS e
JOIN orders AS o
    ON e.employeeID = o.employeeID
JOIN order_details AS od
    ON o.orderID = od.orderID
GROUP BY e.employeeName
ORDER BY total_revenue DESC;

-- Count orders handled by each employee

SELECT e.employeeName,
       COUNT(o.orderID) AS total_orders
FROM employees AS e
JOIN orders AS o
    ON e.employeeID = o.employeeID
GROUP BY e.employeeName
ORDER BY total_orders DESC;

-- ============================================
-- 8. GEOGRAPHIC SALES ANALYSIS
-- ============================================

-- Calculate revenue by customer country

SELECT c.country,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customerID = o.customerID
JOIN order_details AS od
    ON o.orderID = od.orderID
GROUP BY c.country
ORDER BY total_revenue DESC;

-- ============================================
-- 9. TIME TREND ANALYSIS
-- ============================================

-- Review order dates

SELECT orderID,
       orderDate
FROM orders
ORDER BY orderDate
LIMIT 20;

-- Convert order dates into year-month format

SELECT orderDate,
       strftime('%Y-%m', orderDate) AS sales_month
FROM orders
LIMIT 20;

-- Calculate monthly revenue

SELECT strftime('%Y-%m', o.orderDate) AS sales_month,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM orders AS o
JOIN order_details AS od
    ON o.orderID = od.orderID
GROUP BY sales_month
ORDER BY sales_month;

-- Calculate yearly revenue

SELECT strftime('%Y', o.orderDate) AS sales_year,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM orders AS o
JOIN order_details AS od
    ON o.orderID = od.orderID
GROUP BY sales_year
ORDER BY sales_year;

-- ============================================
-- 10. CUSTOMER SEGMENTATION
-- ============================================

-- Practice CASE WHEN by categorizing product prices

SELECT productName,
       unitPrice,
       CASE
           WHEN unitPrice >= 50 THEN 'High Price'
           WHEN unitPrice >= 20 THEN 'Medium Price'
           ELSE 'Low Price'
       END AS price_category
FROM products;

-- Review customer revenue before creating segments

SELECT c.companyName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customerID = o.customerID
JOIN order_details AS od
    ON o.orderID = od.orderID
GROUP BY c.companyName
ORDER BY total_revenue DESC;

-- Segment customers based on total revenue

SELECT c.companyName,
       SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS total_revenue,
       CASE
           WHEN SUM(od.unitPrice * od.quantity * (1 - od.discount)) >= 20000
               THEN 'High Value'
           WHEN SUM(od.unitPrice * od.quantity * (1 - od.discount)) >= 10000
               THEN 'Medium Value'
           ELSE 'Low Value'
       END AS customer_segment
FROM customers AS c
JOIN orders AS o
    ON c.customerID = o.customerID
JOIN order_details AS od
    ON o.orderID = od.orderID
GROUP BY c.companyName
ORDER BY total_revenue DESC;

-- Count customers in each revenue segment

SELECT customer_segment,
       COUNT(*) AS customer_count
FROM (
    SELECT c.companyName,
           CASE
               WHEN SUM(od.unitPrice * od.quantity * (1 - od.discount)) >= 20000
                   THEN 'High Value'
               WHEN SUM(od.unitPrice * od.quantity * (1 - od.discount)) >= 10000
                   THEN 'Medium Value'
               ELSE 'Low Value'
           END AS customer_segment
    FROM customers AS c
    JOIN orders AS o
        ON c.customerID = o.customerID
    JOIN order_details AS od
        ON o.orderID = od.orderID
    GROUP BY c.companyName
) AS customer_segments
GROUP BY customer_segment
ORDER BY customer_count DESC;

-- ============================================
-- 11. DATA QUALITY CHECKS
-- ============================================

-- Check for orders with missing shipped dates

SELECT orderID,
       orderDate,
       shippedDate
FROM orders
WHERE shippedDate IS NULL;

-- Count orders with missing shipped dates

SELECT COUNT(*) AS missing_shipped_dates
FROM orders
WHERE shippedDate IS NULL;

-- Check for duplicate order IDs

SELECT orderID,
       COUNT(*) AS duplicate_count
FROM orders
GROUP BY orderID
HAVING COUNT(*) > 1;

-- Check for zero or negative quantities

SELECT orderID,
       productID,
       quantity
FROM order_details
WHERE quantity <= 0;

-- Review the minimum and maximum discount values

SELECT MIN(discount) AS minimum_discount,
       MAX(discount) AS maximum_discount
FROM order_details;

-- Check for orders without matching customers

SELECT o.orderID,
       o.customerID
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customerID = c.customerID
WHERE c.customerID IS NULL;

-- Check for order details without matching orders

SELECT od.orderID,
       od.productID
FROM order_details AS od
LEFT JOIN orders AS o
    ON od.orderID = o.orderID
WHERE o.orderID IS NULL;

-- Check for order details without matching products

SELECT od.orderID,
       od.productID
FROM order_details AS od
LEFT JOIN products AS p
    ON od.productID = p.productID
WHERE p.productID IS NULL;

-- Check for products without matching categories

SELECT p.productID,
       p.productName,
       p.categoryID
FROM products AS p
LEFT JOIN categories AS c
    ON p.categoryID = c.categoryID
WHERE c.categoryID IS NULL;

-- Check for discount values outside the valid range

SELECT orderID,
       productID,
       discount
FROM order_details
WHERE discount < 0
   OR discount > 1;
   
-- Check for missing customer information

SELECT customerID,
       companyName,
       country
FROM customers
WHERE companyName IS NULL
   OR country IS NULL;
   
-- Check for duplicate customer IDs

SELECT customerID,
       COUNT(*) AS duplicate_count
FROM customers
GROUP BY customerID
HAVING COUNT(*) > 1;

-- Find customers without matching orders

SELECT c.customerID,
       c.companyName
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customerID = o.customerID
WHERE o.orderID IS NULL;

/*
=======================================================
ANALYSIS SUMMARY
=======================================================

The analysis examined customer, product, category,
geographic, employee-associated, and time-based sales
performance using Northwind Traders data.

Data-quality checks were also performed for missing values,
duplicates, invalid numeric values, and unmatched table
relationships.

Detailed findings and business recommendations are documented in the project README.
=======================================================
*/