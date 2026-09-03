-- XYZ Retail Company
-- Goal   : Inserting Intentionally Dirty Data
-- Step Two : Inserting Uncleaned Data
-- Notes  : Data contains intentionally introduced data quality issues
--         : This file only contains INSERT statements
--         : This uncleaned inserted data generated using AI
-- =================================================================


-- ================================================================
-- TRUNCATING BRANCHES TABLE
-- ================================================================
PRINT 'Truncating branches table...';

TRUNCATE TABLE branches;

PRINT 'branches table truncated successfully.';
GO


-- ================================================================
-- INSERTING DATA INTO BRANCHES TABLE
-- ================================================================
PRINT 'Inserting data into branches table...';

INSERT INTO branches (
    branch_id,
    branch_name,
    city,
    region,
    opened_date
)
VALUES
    (1, 'Main Branch',       'Cairo',      'Greater Cairo', '2015-03-10'),
    (2, 'Nasr City Branch',  'Cairo',      'Greater Cairo', '2016-07-01'),
    (3, 'Alex Branch',       'Alexandria', 'Delta',         '2017-01-15'),
    (4, 'Giza Branch',       'Giza',       'Greater Cairo', '2018-05-20'),
    (5, 'Assiut Branch',     'Assiut',     'Upper Egypt',   '2020-11-01');

PRINT 'branches data inserted successfully.';
GO


-- ================================================================
-- TRUNCATING EMPLOYEES TABLE
-- ================================================================
PRINT 'Truncating employees table...';

TRUNCATE TABLE employees;

PRINT 'employees table truncated successfully.';
GO


-- ================================================================
-- INSERTING DATA INTO EMPLOYEES TABLE
-- ================================================================
PRINT 'Inserting data into employees table...';

INSERT INTO employees (
    employee_id,
    full_name,
    job_title,
    gender,
    phone,
    email,
    hire_date,
    salary,
    branch_id,
    is_active
)
VALUES
    (1, 'Ahmed Mohamed Ali', 'Data Analyst', 'Male',
     '01012345678', 'ahmed.ali@xyz.com', '2018-01-15', 8500, 1, '1'),

    (2, 'Sara Hassan Ibrahim', 'Sales Manager', 'Female',
     '01198765432', 'sara.hassan@xyz.com', '2019-03-20', 7200, 2, 'Yes'),

    (3, 'Mahmoud Abdullah Salem', 'Branch Manager', 'M',
     '01501234567', 'mahmoud.s@xyz.com', '2017-06-01', 9000, 1, 'true'),

    -- Inconsistent gender value
    (4, 'Khaled Youssef Ahmed', 'Sales Representative', 'male',
     '01112233445', 'khaled.y@xyz.com', '2020-09-10', 6800, 3, 'yes'),

    -- Inconsistent gender value + different phone format
    (5, 'Nora Omar Farouk', 'Sales Representative', 'F',
     '012-3456-7890', 'noura.omar@xyz.com', '2021-02-28', 6500, 4, '1'),

    -- Different date format
    (6, 'Tarek Reda Mostafa', 'Sales Analyst', 'Male',
     '01356789012', 'tarek.r@xyz.com', '01/07/2019', 7800, 2, 'Yes'),

    -- Phone contains spaces and symbols
    (7, 'Mona Saad Eldin', 'Cashier', 'Female',
     '011 9876 5432', 'mona.saad@xyz.com', '15-08-2020', 6200, 5, '0'),

    -- Phone format with brackets
    (8, 'Alaa Eldin Kamal', 'Cashier', 'Male',
     '(010)45678901', 'alaa.k@xyz.com', '2022-03-15', 5500, 3, 'false'),

    -- Invalid email
    (9, 'Heba Ramadan Khalil', 'Accountant', 'Female',
     '01198760000', 'heba_ramadan', '2021-11-20', 6000, 1, 'Yes'),

    -- Negative salary
    (10, 'Karim Fathy Atta', 'Sales Representative', 'Male',
     '01012340000', 'karim.fathy@xyz.com', '2019-08-05', -500, 4, '1'),

    -- Zero salary
    (11, 'Reem Ibrahim Nasser', 'Employee', 'Female',
     '01512345999', 'reem.i@xyz.com', '2023-01-10', 0, 2, 'Yes'),

    -- Invalid branch_id
    (12, 'Samer Waleed Gamal', 'Sales Representative', 'Male',
     '0101234', 'samer.w@xyz.com', '2020-04-01', 7100, 99, '1'),

    -- Duplicate email and phone
    (13, 'Dina Magdy Hussein', 'Cashier', 'Female',
     '01012345678', 'ahmed.ali@xyz.com', '2021-07-15', 6700, 3, '1'),

    -- Duplicate record with leading/trailing spaces
    (14, '  Ahmed Mohamed Ali  ', 'Data Analyst', 'Male',
     '01012345678', 'ahmed.ali@xyz.com', '2018-01-15', 8500, 1, '1'),

    -- NULL full_name
    (15, NULL, 'Cashier', 'Male',
     '01099990000', 'unknown@xyz.com', '2022-06-01', 5000, 5, 'Yes'),

    -- NULL gender
    (16, 'Youssef Hamdy Shaker', 'Sales Manager', NULL,
     '01522223333', 'yousef.h@xyz.com', '2020-12-01', 7400, 4, 'Yes'),

    -- NULL phone + spaces in job title
    (17, 'Nadia Fekry Salama', '  Accountant  ', 'Female',
     NULL, 'nadia.f@xyz.com', '2019-05-18', 6900, 1, '1'),

    -- Future hire date
    (18, 'Basem Adel Tawfik', 'Sales Representative', 'Male',
     '01011112222', 'basem.a@xyz.com', '2030-01-01', 7300, 2, '1');

PRINT 'employees data inserted successfully.';
GO


-- ================================================================
-- TRUNCATING CUSTOMERS TABLE
-- ================================================================
PRINT 'Truncating customers table...';

TRUNCATE TABLE customers;

PRINT 'customers table truncated successfully.';
GO


-- ================================================================
-- INSERTING DATA INTO CUSTOMERS TABLE
-- ================================================================
PRINT 'Inserting data into customers table...';

INSERT INTO customers (
    customer_id,
    full_name,
    gender,
    phone,
    email,
    city,
    registration_date,
    loyalty_points,
    customer_type
)
VALUES
    (1, 'Mohamed Abdelaziz', 'Male',
     '01011111111', 'mohamed.a@email.com', 'Cairo',
     '2020-01-15', 1500, 'VIP'),

    (2, 'Fatma El Zahraa', 'Female',
     '01022222222', 'fatma.z@email.com', 'Giza',
     '2020-03-20', 800, 'Regular'),

    (3, 'Omar Sherif', 'Male',
     '01033333333', 'omar.sh@email.com', 'Alexandria',
     '2021-05-10', 2200, 'VIP'),

    -- Inconsistent city spelling
    (4, 'Aya Mostafa', 'Female',
     '01044444444', 'aya.m@email.com', 'Cairo',
     '2021-08-01', 400, 'regular'),

    -- Inconsistent city and customer type
    (5, 'Hossam Eldin', 'Male',
     '01055555555', 'hossam.d@email.com', 'Alex',
     '2022-01-01', 650, 'Regular'),

    -- Different city naming convention
    (6, 'Mariam Anwar', 'Female',
     '01066666666', 'mariam.anwar@email.com', 'cairo',
     '2022-06-15', 1800, 'vip'),

    -- Different gender representation
    (7, 'Yehia Awad', 'M',
     '01077777777', 'yahya.a@email.com', 'Cairo',
     '2022-09-30', 300, 'Regular'),

    (8, 'Salma Hamdy', 'Female',
     '01088888888', 'salma.h@email.com', 'Assiut',
     '2023-01-05', 950, 'Regular'),

    -- Duplicate customer information
    (9, 'Mohamed Abdelaziz', 'Male',
     '01011111111', 'mohamed.a@email.com', 'Cairo',
     '2020-01-15', 1500, 'VIP'),

    -- Negative loyalty points
    (10, 'Noha Saleh', 'Female',
     '01010101010', 'noha.s@email.com', 'Cairo',
     '2023-07-10', -200, 'Regular'),

    -- NULL full_name
    (11, NULL, 'Male',
     '01012121212', 'x.gouda@email.com', 'Giza',
     '2023-04-01', 200, 'Regular'),

    -- NULL gender
    (12, 'Rana Mohamed', NULL,
     '01013131313', 'rana.x@email.com', 'Alexandria',
     '2023-05-12', 500, 'Regular'),

    -- Unrealistic loyalty points
    (13, 'Gamal Fahmy', 'Male',
     '01014141414', 'gamal.f@email.com', 'Cairo',
     '2021-11-11', 1000000, 'VIP'),

    -- Invalid email
    (14, 'Shaimaa Raafat', 'Female',
     '01015151515', 'shaimaa_rafat', 'Giza',
     '2022-08-08', 600, 'Regular'),

    -- Different phone format
    (15, 'Mostafa Adel', 'Male',
     '010-1616-1616', 'mostafa.a@email.com', 'Cairo',
     '2023-09-10', 350, 'regular');

PRINT 'customers data inserted successfully.';
GO


-- ================================================================
-- TRUNCATING PRODUCTS TABLE
-- ================================================================
PRINT 'Truncating products table...'
 
TRUNCATE TABLE products;

PRINT 'products table truncated successfully.';
GO


-- ================================================================
-- INSERTING DATA INTO PRODUCTS TABLE
-- ================================================================
PRINT 'Inserting data into products table...';

INSERT INTO products (
    product_id,
    product_name,
    category,
    unit_cost,
    unit_price,
    stock_qty,
    supplier,
    is_available
)
VALUES
    (1, 'Dell Laptop i5', 'Electronics',
     '5200', '8500', 45, 'Advanced Computers', '1'),

    (2, 'Samsung A54', 'Electronics',
     '4100', '6200', 120, 'Direct Import', 'Yes'),

    (3, 'HP LaserJet Printer', 'Electronics',
     '2500', '3800', 30, 'Advanced Computers', 'true'),

    -- Inconsistent category
    (4, 'Office Chair', 'Office Furniture',
     '750', '1200', 80, 'Nile Furniture', '1'),

    (5, 'Large Wooden Desk', 'office furniture',
     '2200', '3500', 25, 'Nile Furniture', 'yes'),

    -- Inconsistent category
    (6, 'Pen Set', 'Office Supplies',
     '50', '85', 500, 'Business Supplies', 'Yes'),

    (7, 'A4 Paper Pack', 'Office Supplies',
     '30', '48', 1000, 'Business Supplies', '1'),

    -- Different category casing
    (8, 'USB Flash 64GB', 'electronics',
     '90', '150', 200, 'Direct Import', 'Yes'),

    (9, 'LG 24 Inch Monitor', 'Electronics',
     '1900', '2800', 55, 'Direct Import', '1'),

    -- Negative unit_price
    (10, 'Bluetooth Speaker', 'Electronics',
     '200', '-350', 75, 'Direct Import', 'Yes'),

    -- Zero unit_cost
    (11, 'Laptop Bag', 'Accessories',
     '0', '180', 90, 'Egyptian Leather Factory', '1'),

    -- Negative stock
    (12, 'Wireless Mouse', 'Accessories',
     '160', '280', -10, 'Direct Import', 'Yes'),

    -- NULL product_name
    (13, NULL, 'Accessories',
     '70', '120', 60, 'Direct Import', '1'),

    -- Selling price lower than cost
    (14, 'Gaming Headset', 'Electronics',
     '600', '400', 40, 'Direct Import', 'yes'),

    -- NULL category
    (15, 'RAM 8GB', NULL,
     '300', '450', 65, 'Advanced Computers', '1');

PRINT 'products data inserted successfully.';
GO


-- ================================================================
-- TRUNCATING ORDERS TABLE
-- ================================================================
PRINT 'Truncating orders table...';

TRUNCATE TABLE orders;

PRINT 'orders table truncated successfully.';
GO


-- ================================================================
-- INSERTING DATA INTO ORDERS TABLE
-- ================================================================
PRINT 'Inserting data into orders table...';

INSERT INTO orders (
    order_id,
    customer_id,
    employee_id,
    branch_id,
    order_date,
    delivery_date,
    payment_method,
    total_amount,
    status,
    notes
)
VALUES
    (1, 1, 3, 1, '2023-01-10', '2023-01-13',
     'Cash', '8500', 'Completed', NULL),

    (2, 2, 4, 3, '2023-01-15', '2023-01-18',
     'Visa', '1200', 'Completed', NULL),

    (3, 3, 1, 1, '2023-02-01', '2023-02-05',
     'Vodafone Cash', '6200', 'Completed', NULL),

    (4, 1, 2, 2, '2023-02-20', '2023-02-23',
     'Cash', '3800', 'Completed', NULL),

    -- Inconsistent status
    (5, 4, 5, 4, '2023-03-05', '2023-03-10',
     'Visa', '2800', 'completed', NULL),

    -- Cancelled order with zero amount
    (6, 5, 3, 1, '2023-03-18', '2023-03-22',
     'Cash', '0', 'Cancelled', 'Customer cancelled the order'),

    -- Inconsistent status
    (7, 6, 4, 3, '2023-04-02', '2023-04-06',
     'Visa', '6200', 'Delivered', NULL),

    -- NULL delivery date
    (8, 7, 1, 1, '2023-04-15', NULL,
     'Cash', '85', 'Processing', NULL),

    -- Inconsistent payment method
    (9, 8, 2, 2, '2023-05-01', '2023-05-04',
     'VISA', '8500', 'Completed', NULL),

    (10, 9, 5, 5, '2023-05-20', '2023-05-25',
     'cash', '280', 'Completed', NULL),

    -- Delivery date before order date
    (11, 10, 3, 1, '2023-06-10', '2023-06-05',
     'Cash', '150', 'Completed', NULL),

    -- Invalid customer_id
    (12, 999, 4, 3, '2023-06-25', '2023-06-28',
     'Visa', '3500', 'Completed', NULL),

    -- NULL employee_id
    (13, 2, NULL, 2, '2023-07-01', '2023-07-05',
     'Cash', '48', 'Completed', NULL),

    -- Different date format
    (14, 3, 1, 1, '15/07/2023', '20/07/2023',
     'Visa', '9000', 'Completed', NULL),

    -- Zero total amount for a completed order
    (15, 5, 4, 4, '2023-08-01', '2023-08-05',
     'Vodafone Cash', '0', 'Completed', NULL),

    -- Negative total amount
    (16, 6, 2, 3, '2023-08-20', '2023-08-24',
     'Cash', '-500', 'Completed', NULL),

    -- Duplicate order
    (17, 1, 3, 1, '2023-01-10', '2023-01-13',
     'Cash', '8500', 'Completed', NULL),

    -- NULL status
    (18, 8, 5, 5, '2023-09-01', '2023-09-05',
     'Visa', '2200', NULL, NULL);

PRINT 'orders data inserted successfully.';
GO


-- ================================================================
-- TRUNCATING ORDER_ITEMS TABLE
-- ================================================================
PRINT 'Truncating order_items table...';

TRUNCATE TABLE order_items;

PRINT 'order_items table truncated successfully.';
GO


-- ================================================================
-- INSERTING DATA INTO ORDER_ITEMS TABLE
-- ================================================================
PRINT 'Inserting data into order_items table...';

INSERT INTO order_items (
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount
)
VALUES
    (1, 1, 1, 1, '8500', '0'),
    (2, 2, 4, 1, '1200', '0'),
    (3, 3, 2, 1, '6200', '0'),
    (4, 4, 3, 1, '3800', '0'),
    (5, 5, 9, 1, '2800', '0'),
    (6, 7, 2, 1, '6200', '0'),
    (7, 8, 6, 2, '85', '10'),
    (8, 9, 1, 1, '8500', '0'),
    (9, 10, 12, 1, '280', '5'),
    (10, 11, 8, 1, '150', '0'),
    (11, 12, 5, 1, '3500', '0'),
    (12, 13, 7, 1, '48', '0'),

    -- Multiple items for the same order
    (13, 14, 9, 2, '2800', '0'),
    (14, 14, 1, 1, '8500', '0'),

    -- Zero quantity
    (15, 15, 6, 0, '85', '0'),

    -- Negative quantity
    (16, 16, 4, -2, '1200', '0'),

    -- Invalid order_id
    (17, 999, 1, 1, '8500', '0'),

    -- Invalid product_id
    (18, 1, 888, 1, '500', '0'),

    -- Discount greater than 100%
    (19, 9, 6, 3, '85', '150'),

    -- Incorrect unit price compared with product price
    (20, 10, 8, 2, '9999', '0'),

    (21, 18, 15, 1, '450', '0'),
    (22, 18, 9, 1, '2800', '0');

PRINT 'order_items data inserted successfully.';
GO


-- ================================================================
-- FINAL MESSAGE
-- ================================================================
PRINT '================================================';
PRINT 'ALL DIRTY DATA INSERTED SUCCESSFULLY.';
PRINT '================================================';
GO

