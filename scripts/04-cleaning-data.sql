-- XYZ Retail Company
-- Goal        : Cleaning Data Using SQL
-- Step Four   : Cleaning Data
-- Notes       : Cleaning and standardizing data 
-- =================================================================


-- ================================================================
-- CLEANING BRANCHES TABLE
-- ================================================================

SELECT
    branch_id,
    TRIM(branch_name) AS branch_name,
    TRIM(city) AS city,
    TRIM(region) AS region,
    FORMAT(TRY_CAST(opened_date AS DATE), 'yyyy-MM-dd') AS opened_date
FROM branches;
-- Cleaning branch names, cities, regions, and date format.


UPDATE branches
SET
    branch_name = TRIM(branch_name),
    city = TRIM(city),
    region = TRIM(region),
    opened_date = FORMAT(TRY_CAST(opened_date AS DATE), 'yyyy-MM-dd');
-- Updating branches table with cleaned values.


-- ================================================================
-- CLEANING CUSTOMERS TABLE
-- ================================================================

-- Standardizing customer data

SELECT
    customer_id,
    TRIM(COALESCE(full_name, 'Unknown')) AS full_name,

    TRIM(
        CASE
            WHEN gender IN ('Male', 'male', 'M', 'm') THEN 'Male'
            WHEN gender IN ('Female', 'female', 'F', 'f') THEN 'Female'
            ELSE 'N/A'
        END
    ) AS gender,

    REPLACE(phone, '-', '') AS phone,

    TRIM(
        CASE
            WHEN email NOT LIKE '%@email.com' THEN email + '@email.com'
            ELSE email
        END
    ) AS email,

    TRIM(
        CASE
            WHEN city = 'Alex' THEN 'Alexandria'
            ELSE city
        END
    ) AS city,

    FORMAT(
        TRY_CAST(registration_date AS DATE),
        'yyyy-MM-dd'
    ) AS registration_date,

    ABS(
        CASE
            WHEN loyalty_points > 2000
                 AND customer_type IN ('VIP', 'Vip', 'vip')
                THEN 2000

            WHEN loyalty_points > 2000
                 AND customer_type IN ('REGULAR', 'Regular', 'regular')
                THEN 2000

            ELSE loyalty_points
        END
    ) AS loyalty_points,

    TRIM(
        CASE
            WHEN customer_type IN ('VIP', 'Vip', 'vip') THEN 'Vip'
            WHEN customer_type IN ('REGULAR', 'Regular', 'regular') THEN 'Regular'
            ELSE customer_type
        END
    ) AS customer_type

FROM customers;
-- Cleaning customer names, gender, phone numbers, emails, cities,
-- registration dates, loyalty points, and customer types.


-- ================================================================
-- EXPLORING DUPLICATED CUSTOMER PHONES
-- ================================================================

SELECT
    phone,
    COUNT(phone) AS duplicated_phone
FROM customers
GROUP BY phone
HAVING COUNT(phone) > 1;
-- Identifying duplicated customer phone numbers.


SELECT
    customer_id,
    phone,
    registration_date
FROM customers
WHERE phone = '01011111111';
-- Exploring customer records that share the duplicated phone number.


-- ================================================================
-- EXPLORING DUPLICATED CUSTOMER EMAILS
-- ================================================================

SELECT
    full_name,
    email,
    COUNT(email) AS duplicated_email
FROM customers
GROUP BY full_name, email
HAVING COUNT(email) > 1;
-- Identifying duplicated customer email addresses.


SELECT
    customer_id,
    phone,
    email,
    registration_date
FROM customers
WHERE email = 'mohamed.a@email.com'
   OR phone = '01011111111';
-- Exploring customer records related to the duplicated email or phone.


DELETE FROM customers
WHERE customer_id = 9;
-- Removing the duplicated customer record.


-- ================================================================
-- UPDATING CUSTOMERS TABLE
-- ================================================================

UPDATE customers
SET
    full_name = TRIM(COALESCE(full_name, 'Unknown')),
    gender = TRIM(
        CASE
            WHEN gender IN ('Male', 'male', 'M', 'm') THEN 'Male'
            WHEN gender IN ('Female', 'female', 'F', 'f') THEN 'Female'
            ELSE 'N/A'
        END
    ),
    phone = REPLACE(phone, '-', ''),
    email = TRIM(
        CASE
            WHEN email NOT LIKE '%@email.com' THEN email + '@email.com'
            ELSE email
        END
    ),
    city = TRIM(
        CASE
            WHEN city = 'Alex' THEN 'Alexandria'
            ELSE city
        END
    ),
    registration_date = FORMAT(
        TRY_CAST(registration_date AS DATE),
        'yyyy-MM-dd'
    ),
    loyalty_points = ABS(
        CASE
            WHEN loyalty_points > 2000
                 AND customer_type IN ('VIP', 'Vip', 'vip')
                THEN 2000

            WHEN loyalty_points > 2000
                 AND customer_type IN ('REGULAR', 'Regular', 'regular')
                THEN 2000

            ELSE loyalty_points
        END
    ),
    customer_type = TRIM(
        CASE
            WHEN customer_type IN ('VIP', 'Vip', 'vip') THEN 'Vip'
            WHEN customer_type IN ('REGULAR', 'Regular', 'regular') THEN 'Regular'
            ELSE customer_type
        END
    );
-- Updating customers table with standardized and cleaned values.


-- ============================================================================


-- ================================================================
-- CLEANING PRODUCTS TABLE
-- ================================================================

SELECT
    product_id,
    TRIM(COALESCE(product_name, 'N/A')) AS product_name,
    TRIM(COALESCE(category, 'N/A')) AS category,
    ABS(TRY_CAST(unit_cost AS INT)) AS unit_cost,

    ABS(
        CASE
            WHEN ABS(TRY_CAST(unit_price AS INT))
                 < ABS(TRY_CAST(unit_cost AS INT))
                THEN ABS(TRY_CAST(unit_cost AS INT)) * 1.5
            ELSE unit_price
        END
    ) AS unit_price,

    ABS(TRY_CAST(stock_qty AS INT)) AS stock_qty,
    TRIM(supplier) AS supplier,

    TRIM(
        CASE
            WHEN is_available IN (1, '1', 'true', 'True', 'TRUE', 'YES', 'Yes', 'yes')
                THEN 'Yes'
            ELSE 'No'
        END
    ) AS is_available

FROM products;
-- Cleaning product names, categories, prices, stock quantities,
-- suppliers, and availability status.


-- ================================================================
-- UPDATING PRODUCTS TABLE
-- ================================================================

UPDATE products
SET
    product_name = TRIM(COALESCE(product_name, 'N/A')),
    category = TRIM(COALESCE(category, 'N/A')),
    unit_cost = ABS(TRY_CAST(unit_cost AS INT)),

    unit_price = ABS(
        CASE
            WHEN ABS(TRY_CAST(unit_price AS INT))
                 < ABS(TRY_CAST(unit_cost AS INT))
                THEN ABS(TRY_CAST(unit_cost AS INT)) * 1.5
            ELSE unit_price
        END
    ),

    stock_qty = ABS(TRY_CAST(stock_qty AS INT)),
    supplier = TRIM(supplier),

    is_available = TRIM(
        CASE
            WHEN is_available IN (1, '1', 'true', 'True', 'TRUE', 'YES', 'Yes', 'yes')
                THEN 'Yes'
            ELSE 'No'
        END
    );
-- Updating products table with cleaned and standardized values.


-- ============================================================================


-- ================================================================
-- CLEANING EMPLOYEES TABLE
-- ================================================================

SELECT
    employee_id,
    TRIM(COALESCE(full_name, 'N/A')) AS full_name,
    TRIM(COALESCE(job_title, 'N/A')) AS job_title,

    TRIM(
        CASE
            WHEN gender IN ('M', 'male') THEN 'Male'
            WHEN gender IN ('F', 'Female') THEN 'Female'
            ELSE 'N/A'
        END
    ) AS gender,

    TRIM(
        CASE
            WHEN phone IS NULL
                 OR LEN(REPLACE(TRANSLATE(phone, '() ', '---'), '-', '')) < 11
                THEN 'invalid'
            ELSE REPLACE(TRANSLATE(phone, '() ', '---'), '-', '')
        END
    ) AS phone,

    TRIM(
        CASE
            WHEN email NOT LIKE '%@xyz.com'
                THEN email + '@xyz.com'
            ELSE email
        END
    ) AS email,

    CASE
        WHEN FORMAT(TRY_CAST(hire_date AS DATE), 'yyyy-MM-dd') > GETDATE()
            THEN 'invalid'

        WHEN TRY_CONVERT(DATE, hire_date, 105) IS NOT NULL
            THEN FORMAT(
                TRY_CONVERT(DATE, hire_date, 105),
                'yyyy-MM-dd'
            )

        ELSE FORMAT(
            TRY_CAST(hire_date AS DATE),
            'yyyy-MM-dd'
        )
    END AS hire_date,

    CASE
        WHEN CAST(salary AS INT) <= 0
            THEN AVG(CAST(salary AS INT)) OVER()
        ELSE CAST(salary AS INT)
    END AS salary,

    CASE
        WHEN branch_id NOT IN (
            SELECT branch_id
            FROM branches
        )
            THEN 0
        ELSE branch_id
    END AS branch_id,

    TRIM(
        CASE
            WHEN is_active IN ('0', 'false') THEN 'No'
            ELSE 'Yes'
        END
    ) AS is_active

FROM employees;
-- Cleaning employee names, job titles, gender, phones, emails,
-- hire dates, salaries, branch IDs, and active status.


-- ================================================================
-- EXPLORING DUPLICATED EMPLOYEE PHONES
-- ================================================================

SELECT
    phone,
    COUNT(phone) AS duplicated_phone
FROM employees
GROUP BY phone
HAVING COUNT(phone) > 1;
-- Identifying duplicated employee phone numbers.


SELECT
    employee_id,
    full_name,
    phone,
    hire_date
FROM employees
WHERE phone = '01012345678';
-- Exploring employee records that share the duplicated phone number.


-- ================================================================
-- EXPLORING DUPLICATED EMPLOYEE EMAILS
-- ================================================================

SELECT
    email,
    COUNT(email) AS duplicated_email
FROM employees
GROUP BY email
HAVING COUNT(email) > 1;
-- Identifying duplicated employee email addresses.


SELECT
    employee_id,
    full_name,
    phone,
    email,
    hire_date
FROM employees
WHERE email = 'ahmed.ali@xyz.com'
   OR phone = '01012345678';
-- Exploring employee records related to the duplicated email or phone.


DELETE FROM employees
WHERE employee_id = 14;
-- Removing the duplicated employee record.


UPDATE employees
SET email = 'dina.m@xyz.com'
WHERE employee_id = 13;
-- Updating the duplicated employee email with the correct email.


-- ================================================================
-- UPDATING EMPLOYEES TABLE
-- ================================================================

WITH AvgSalaryCTE AS (
    SELECT AVG(TRY_CAST(salary AS INT)) AS avg_sal
    FROM employees
    WHERE TRY_CAST(salary AS INT) > 0
)
UPDATE employees
SET
    full_name = TRIM(COALESCE(full_name, 'N/A')),
    job_title = TRIM(COALESCE(job_title, 'N/A')),

    gender = TRIM(
        CASE
            WHEN gender IN ('M', 'male') THEN 'Male'
            WHEN gender IN ('F', 'Female') THEN 'Female'
            ELSE 'N/A'
        END
    ),

    phone = TRIM(
        CASE
            WHEN phone IS NULL
                 OR LEN(REPLACE(TRANSLATE(phone, '() ', '---'), '-', '')) < 11
                THEN 'invalid'
            ELSE REPLACE(TRANSLATE(phone, '() ', '---'), '-', '')
        END
    ),

    email = TRIM(
        CASE
            WHEN email NOT LIKE '%@xyz.com'
                THEN email + '@xyz.com'
            ELSE email
        END
    ),

    hire_date =
        CASE
            WHEN FORMAT(TRY_CAST(hire_date AS DATE), 'yyyy-MM-dd') > GETDATE()
                THEN 'invalid'

            WHEN TRY_CONVERT(DATE, hire_date, 105) IS NOT NULL
                THEN FORMAT(
                    TRY_CONVERT(DATE, hire_date, 105),
                    'yyyy-MM-dd'
                )

            ELSE FORMAT(
                TRY_CAST(hire_date AS DATE),
                'yyyy-MM-dd'
            )
        END,

    salary =
        CASE
            WHEN TRY_CAST(salary AS INT) IS NULL OR TRY_CAST(salary AS INT) <= 0
                THEN (SELECT avg_sal FROM AvgSalaryCTE)
            ELSE TRY_CAST(salary AS INT)
        END,

    branch_id =
        CASE
            WHEN branch_id NOT IN (
                SELECT branch_id
                FROM branches
            )
                THEN 0
            ELSE branch_id
        END,

    is_active = TRIM(
        CASE
            WHEN is_active IN ('0', 'false') THEN 'No'
            ELSE 'Yes'
        END
    );
-- Updating employees table with cleaned and standardized values.


-- ============================================================================


-- ================================================================
-- CLEANING ORDERS TABLE
-- ================================================================

SELECT
    order_id,

    CASE
        WHEN customer_id NOT IN (
            SELECT customer_id
            FROM customers
        )
            THEN 0
        ELSE customer_id
    END AS customer_id,

    COALESCE(
        CASE
            WHEN employee_id NOT IN (
                SELECT employee_id
                FROM employees
            )
                THEN 0
            ELSE employee_id
        END,
        0
    ) AS employee_id,

    CASE
        WHEN branch_id NOT IN (
            SELECT branch_id
            FROM branches
        )
            THEN 0
        ELSE branch_id
    END AS branch_id,

    CASE
        WHEN FORMAT(TRY_CAST(order_date AS DATE), 'yyyy-MM-dd') > GETDATE()
            THEN 'invalid'

        WHEN TRY_CONVERT(DATE, order_date, 105) IS NOT NULL
            THEN FORMAT(
                TRY_CONVERT(DATE, order_date, 105),
                'yyyy-MM-dd'
            )

        ELSE FORMAT(
            TRY_CAST(order_date AS DATE),
            'yyyy-MM-dd'
        )
    END AS order_date,

    COALESCE(
        CASE
            WHEN FORMAT(TRY_CAST(delivery_date AS DATE), 'yyyy-MM-dd') > GETDATE()
                 OR FORMAT(TRY_CAST(delivery_date AS DATE), 'yyyy-MM-dd')
                    < FORMAT(TRY_CAST(order_date AS DATE), 'yyyy-MM-dd')
                THEN 'invalid'

            WHEN TRY_CONVERT(DATE, delivery_date, 105) IS NOT NULL
                THEN FORMAT(
                    TRY_CONVERT(DATE, delivery_date, 105),
                    'yyyy-MM-dd'
                )

            ELSE FORMAT(
                TRY_CAST(delivery_date AS DATE),
                'yyyy-MM-dd'
            )
        END,
        'invalid'
    ) AS delivery_date,

    TRIM(payment_method) AS payment_method,
    ABS(CAST(total_amount AS INT)) AS total_amount,
    TRIM(COALESCE(status, 'N/A')) AS status,
    TRIM(COALESCE(notes, 'N/A')) AS notes

FROM orders;
-- Cleaning customer, employee, and branch references, dates,
-- payment methods, amounts, status, and notes.


-- ================================================================
-- UPDATING ORDERS TABLE
-- ================================================================

UPDATE orders
SET
    customer_id =
        CASE
            WHEN customer_id NOT IN (
                SELECT customer_id
                FROM customers
            )
                THEN 0
            ELSE customer_id
        END,

    employee_id =
        COALESCE(
            CASE
                WHEN employee_id NOT IN (
                    SELECT employee_id
                    FROM employees
                )
                    THEN 0
                ELSE employee_id
            END,
            0
        ),

    branch_id =
        CASE
            WHEN branch_id NOT IN (
                SELECT branch_id
                FROM branches
            )
                THEN 0
            ELSE branch_id
        END,

    order_date =
        CASE
            WHEN FORMAT(TRY_CAST(order_date AS DATE), 'yyyy-MM-dd') > GETDATE()
                THEN 'invalid'

            WHEN TRY_CONVERT(DATE, order_date, 105) IS NOT NULL
                THEN FORMAT(
                    TRY_CONVERT(DATE, order_date, 105),
                    'yyyy-MM-dd'
                )

            ELSE FORMAT(
                TRY_CAST(order_date AS DATE),
                'yyyy-MM-dd'
            )
        END,

    delivery_date =
        COALESCE(
            CASE
                WHEN FORMAT(TRY_CAST(delivery_date AS DATE), 'yyyy-MM-dd') > GETDATE()
                     OR FORMAT(TRY_CAST(delivery_date AS DATE), 'yyyy-MM-dd')
                        < FORMAT(TRY_CAST(order_date AS DATE), 'yyyy-MM-dd')
                    THEN 'invalid'

                WHEN TRY_CONVERT(DATE, delivery_date, 105) IS NOT NULL
                    THEN FORMAT(
                        TRY_CONVERT(DATE, delivery_date, 105),
                        'yyyy-MM-dd'
                    )

                ELSE FORMAT(
                    TRY_CAST(delivery_date AS DATE),
                    'yyyy-MM-dd'
                )
            END,
            'invalid'
        ),

    payment_method = TRIM(payment_method),
    total_amount = ABS(CAST(total_amount AS INT)),
    status = TRIM(COALESCE(status, 'N/A')),
    notes = TRIM(COALESCE(notes, 'N/A'));
-- Updating orders table with cleaned and standardized values.


-- ============================================================================


-- ================================================================
-- CLEANING ORDER_ITEMS TABLE
-- ================================================================

SELECT
    item_id,

    CASE
        WHEN order_id NOT IN (
            SELECT order_id
            FROM orders
        )
            THEN 0
        ELSE order_id
    END AS order_id,

    CASE
        WHEN product_id NOT IN (
            SELECT product_id
            FROM products
        )
            THEN 0
        ELSE product_id
    END AS product_id,

    ABS(quantity) AS quantity,

    CAST(
        CASE
            WHEN unit_price <> (
                SELECT TOP 1 unit_price
                FROM products p
                WHERE p.product_id = order_items.product_id
            )
                THEN (
                    SELECT TOP 1 unit_price
                    FROM products p
                    WHERE p.product_id = order_items.product_id
                )
            ELSE unit_price
        END AS float
    ) AS unit_price,

    CAST(
        CASE
            WHEN discount > 100 THEN 10
            ELSE discount
        END AS INT
    ) AS discount

FROM order_items;
-- Cleaning order and product references, quantities, unit prices,
-- and discount values.


-- ================================================================
-- UPDATING ORDER_ITEMS TABLE
-- ================================================================

UPDATE order_items
SET
    order_id =
        CASE
            WHEN order_id NOT IN (
                SELECT order_id
                FROM orders
            )
                THEN 0
            ELSE order_id
        END,

    product_id =
        CASE
            WHEN product_id NOT IN (
                SELECT product_id
                FROM products
            )
                THEN 0
            ELSE product_id
        END,

    quantity = ABS(quantity),

    unit_price =
        CAST(
            CASE
                WHEN unit_price <> (
                    SELECT TOP 1 unit_price
                    FROM products p
                    WHERE p.product_id = order_items.product_id
                )
                    THEN (
                        SELECT TOP 1 unit_price
                        FROM products p
                        WHERE p.product_id = order_items.product_id
                    )
                ELSE unit_price
            END AS float
        ),

    discount =
        CAST(
            CASE
                WHEN discount > 100 THEN 10
                ELSE discount
            END AS INT
        );
-- Updating order_items table with cleaned and standardized values.


-- ============================================================================


-- ================================================================
-- FINAL MESSAGE
-- ================================================================

PRINT '================================================';
PRINT 'DATA CLEANING COMPLETED SUCCESSFULLY.';
PRINT '================================================';
GO

