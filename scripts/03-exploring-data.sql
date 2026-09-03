
-- XYZ Retail Company
-- Goal        : Cleaning Data Using SQL
-- Step Three : Exploring Data Quality Issues
-- Notes       : Exploring to identify data quality issues
--               before starting the data cleaning process
-- =================================================================


-- ================================================================
-- EXPLORING ALL TABLES
-- ================================================================

SELECT 'Branches' AS Table_Name, COUNT(*) AS Total_Rows FROM branches UNION ALL
SELECT 'customers' AS Table_Name, COUNT(*) AS Total_Rows FROM customers UNION ALL
SELECT 'employees' AS Table_Name, COUNT(*) AS Total_Rows FROM employees UNION ALL
SELECT 'products' AS Table_Name, COUNT(*) AS Total_Rows FROM products UNION ALL
SELECT 'orders' AS Table_Name, COUNT(*) AS Total_Rows FROM orders UNION ALL
SELECT 'orders_items' AS Table_Name, COUNT(*) AS Total_Rows FROM order_items;
-- Exploring the total number of rows in each table.


-- ================================================================
-- EXPLORING BRANCHES TABLE
-- ================================================================

SELECT *
FROM branches;
-- Exploring all records and columns in the branches table.


SELECT DISTINCT region, city
FROM branches;
-- Exploring unique region and city combinations to detect inconsistent values.


-- ================================================================
-- EXPLORING CUSTOMERS TABLE
-- ================================================================

SELECT TOP 5 *
FROM customers;
-- Exploring a sample of customer records to understand the data structure and values.


SELECT *
FROM customers
WHERE full_name IS NULL;
-- Exploring customers with missing full names.


SELECT DISTINCT gender
FROM customers;
-- Exploring unique gender values to detect inconsistent representations.


SELECT DISTINCT city
FROM customers;
-- Exploring unique city values to detect inconsistent spelling or casing.


SELECT DISTINCT customer_type
FROM customers;
-- Exploring unique customer types to detect inconsistent values or casing.


SELECT
    phone,
    COUNT(phone) AS duplicated_phone
FROM customers
GROUP BY phone
HAVING COUNT(phone) > 1;
-- Exploring duplicated phone numbers among customers.


SELECT
    phone,
    LEN(phone) AS invalid_nums
FROM customers
WHERE LEN(phone) <> 11;
-- Exploring phone numbers that do not contain exactly 11 characters.


SELECT email
FROM customers
WHERE email NOT LIKE '%@email.com';
-- Exploring customer emails that do not match the expected email format.


SELECT
    full_name,
    email,
    COUNT(email) AS duplicated_email
FROM customers
GROUP BY full_name, email
HAVING COUNT(email) > 1;
-- Exploring duplicated customer records based on full name and email.


-- ================================================================
-- EXPLORING EMPLOYEES TABLE
-- ================================================================

SELECT *
FROM employees;
-- Exploring all records and columns in the employees table.


SELECT
    employee_id,
    full_name
FROM employees
WHERE full_name IS NULL;
-- Exploring employees with missing full names.


SELECT
    full_name,
    CASE
        WHEN LEN(full_name) = LEN(TRIM(full_name)) THEN 0
        ELSE 1
    END AS name_flag
FROM employees;
-- Exploring employee names with leading or trailing spaces.


SELECT DISTINCT job_title
FROM employees;
-- Exploring unique job titles to detect inconsistent values or formatting.


SELECT DISTINCT gender
FROM employees;
-- Exploring unique gender values to detect inconsistent representations.


SELECT
    phone,
    COUNT(phone) AS phone_flag
FROM employees
GROUP BY phone
HAVING COUNT(phone) > 1;
-- Exploring duplicated phone numbers among employees.


SELECT email
FROM employees
WHERE email NOT LIKE '%@xyz.com';
-- Exploring employee emails that do not match the expected company email format.


SELECT
    email,
    COUNT(email) AS email_flag
FROM employees
GROUP BY email
HAVING COUNT(email) > 1;
-- Exploring duplicated email addresses among employees.


SELECT
    FORMAT(TRY_CAST(hire_date AS DATE), 'yyyy-MM-dd') AS hire_date
FROM employees
WHERE FORMAT(TRY_CAST(hire_date AS DATE), 'yyyy-MM-dd') > GETDATE();
-- Exploring employees with future hire dates.


SELECT salary
FROM employees
WHERE salary <= 0;
-- Exploring employees with zero or negative salaries.


SELECT DISTINCT branch_id
FROM employees
WHERE branch_id NOT IN (
    SELECT branch_id
    FROM branches
);
-- Exploring employee records linked to non-existing branches.


SELECT DISTINCT is_active
FROM employees;
-- Exploring unique active-status values to detect inconsistent representations.


-- ================================================================
-- EXPLORING PRODUCTS TABLE
-- ================================================================

SELECT *
FROM products;
-- Exploring all records and columns in the products table.


SELECT product_name
FROM products
WHERE product_name IS NULL;
-- Exploring products with missing product names.


SELECT DISTINCT category
FROM products;
-- Exploring unique product categories to detect inconsistent values or casing.


SELECT unit_cost
FROM products
WHERE unit_cost <= 0;
-- Exploring products with zero or negative unit costs.


SELECT unit_price
FROM products
WHERE unit_price <= 0;
-- Exploring products with zero or negative selling prices.


SELECT stock_qty
FROM products
WHERE stock_qty <= 0;
-- Exploring products with zero or negative stock quantities.


SELECT DISTINCT supplier
FROM products;
-- Exploring unique supplier values.


SELECT DISTINCT is_available
FROM products;
-- Exploring unique availability-status values to detect inconsistent representations.


-- ================================================================
-- EXPLORING ORDER_ITEMS TABLE
-- ================================================================

SELECT *
FROM order_items;
-- Exploring all records and columns in the order_items table.


SELECT order_id
FROM order_items
WHERE order_id NOT IN (
    SELECT order_id
    FROM orders
);
-- Exploring order items linked to non-existing orders.


SELECT product_id
FROM order_items
WHERE product_id NOT IN (
    SELECT product_id
    FROM products
);
-- Exploring order items linked to non-existing products.


SELECT quantity
FROM order_items
WHERE quantity <= 0;
-- Exploring order items with zero or negative quantities.


SELECT discount
FROM order_items
WHERE discount > 100;
-- Exploring order items with discounts greater than 100%.


-- ================================================================
-- EXPLORING ORDERS TABLE
-- ================================================================

SELECT *
FROM orders;
-- Exploring all records and columns in the orders table.


SELECT customer_id
FROM orders
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM customers
);
-- Exploring orders linked to non-existing customers.


SELECT employee_id
FROM orders
WHERE employee_id NOT IN (
    SELECT employee_id
    FROM employees
);
-- Exploring orders linked to non-existing employees.


SELECT branch_id
FROM orders
WHERE branch_id NOT IN (
    SELECT branch_id
    FROM branches
);
-- Exploring orders linked to non-existing branches.


SELECT
    order_date,
    delivery_date,
    CASE
        WHEN order_date > delivery_date
             OR delivery_date IS NULL
             OR order_date IS NULL
        THEN 1
        ELSE 0
    END AS date_flag
FROM orders;
-- Exploring orders with missing dates or delivery dates earlier than order dates.


SELECT DISTINCT payment_method
FROM orders;
-- Exploring unique payment methods to detect inconsistent values or casing.


SELECT total_amount
FROM orders
WHERE total_amount <= 0;
-- Exploring orders with zero or negative total amounts.


SELECT *
FROM orders;
-- Exploring all order records for a final review of the orders data.

