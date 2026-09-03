-- XYZ Retail Company
-- Goal   : Cleaning Data Using SQL
-- Step One : Creating Tables with Intentionally Dirty Data
-- Rules  : Using snake_case for naming
-- Notes  : Columns contain intentionally introduced data quality issues
-- =================================================================


-- ================================================================
-- CREATING DATABASE
-- ================================================================

USE MASTER;
GO

PRINT '================================================';
PRINT 'CREATING XYZRetail DATABASE';
PRINT '================================================';

IF DB_ID('XYZRetail') IS NULL
BEGIN
    CREATE DATABASE XYZRetail;
    PRINT 'Database XYZRetail created successfully.';
END
ELSE
BEGIN
    PRINT 'Database XYZRetail already exists.';
END;
GO


-- ================================================================
-- USING XYZRetail DATABASE
-- ================================================================

USE XYZRetail;
GO

PRINT '================================================';
PRINT 'STARTING TABLE CREATION';
PRINT '================================================';


-- ================================================================
-- CREATING BRANCHES TABLE
-- ================================================================

PRINT 'Creating branches table...';

IF OBJECT_ID('dbo.branches', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.branches;
    PRINT 'Existing branches table dropped.';
END;

CREATE TABLE branches (
    branch_id    INT PRIMARY KEY,
    branch_name  VARCHAR(50),     -- Possible leading/trailing spaces
    city         VARCHAR(50),     -- Inconsistent city names or spelling
    region       VARCHAR(50),     -- Inconsistent region names
    opened_date  VARCHAR(50)      -- Inconsistent date formats / invalid dates
);

PRINT 'branches table created successfully.';
GO


-- ================================================================
-- CREATING EMPLOYEES TABLE
-- ================================================================

PRINT 'Creating employees table...';

IF OBJECT_ID('dbo.employees', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.employees;
    PRINT 'Existing employees table dropped.';
END;

CREATE TABLE employees (
    employee_id  INT PRIMARY KEY,
    full_name    VARCHAR(100),    -- Leading/trailing spaces / possible NULLs
    job_title    VARCHAR(50),     -- Inconsistent job title values / extra spaces
    gender       VARCHAR(10),     -- Inconsistent values / possible NULLs
    phone        VARCHAR(50),     -- Different phone formats / invalid numbers
    email        VARCHAR(100),    -- Invalid email format / duplicate emails
    hire_date    VARCHAR(50),     -- Inconsistent date formats / future dates
    salary       VARCHAR(50),     -- Negative, zero, or invalid numeric values
    branch_id    INT,             -- Invalid branch references / orphan records
    is_active    VARCHAR(10)      -- Inconsistent boolean values
);

PRINT 'employees table created successfully.';
GO


-- ================================================================
-- CREATING CUSTOMERS TABLE
-- ================================================================

PRINT 'Creating customers table...';

IF OBJECT_ID('dbo.customers', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.customers;
    PRINT 'Existing customers table dropped.';
END;

CREATE TABLE customers (
    customer_id       INT PRIMARY KEY,
    full_name         VARCHAR(100),    -- Leading/trailing spaces / possible NULLs
    gender            VARCHAR(10),     -- Inconsistent values / possible NULLs
    phone             VARCHAR(50),     -- Different formats / invalid or duplicate numbers
    email             VARCHAR(100),    -- Invalid email format / duplicate emails
    city              VARCHAR(50),     -- Inconsistent spelling and naming conventions
    registration_date VARCHAR(50),     -- Inconsistent date formats / invalid dates
    loyalty_points    INT,             -- Negative or unrealistic values
    customer_type     VARCHAR(50)      -- Inconsistent category values / casing
);

PRINT 'customers table created successfully.';
GO


-- ================================================================
-- CREATING PRODUCTS TABLE
-- ================================================================

PRINT 'Creating products table...';

IF OBJECT_ID('dbo.products', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.products;
    PRINT 'Existing products table dropped.';
END;

CREATE TABLE products (
    product_id    INT PRIMARY KEY,
    product_name  VARCHAR(50),     -- Possible NULLs / inconsistent naming
    category      VARCHAR(50),     -- Inconsistent category names / spelling
    unit_cost     VARCHAR(50),     -- Invalid, zero, or negative numeric values
    unit_price    VARCHAR(50),     -- Invalid, zero, or negative numeric values
    stock_qty     INT,             -- Negative or unrealistic stock quantities
    supplier      VARCHAR(50),     -- Possible inconsistent supplier names
    is_available  VARCHAR(10)      -- Inconsistent boolean values
);

PRINT 'products table created successfully.';
GO


-- ================================================================
-- CREATING ORDERS TABLE
-- ================================================================

PRINT 'Creating orders table...';

IF OBJECT_ID('dbo.orders', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.orders;
    PRINT 'Existing orders table dropped.';
END;

CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT,             -- Invalid customer references / orphan records
    employee_id     INT,             -- NULL or invalid employee references
    branch_id       INT,             -- Invalid branch references
    order_date      VARCHAR(50),     -- Inconsistent date formats / invalid dates
    delivery_date   VARCHAR(50),     -- Inconsistent formats / delivery before order date
    payment_method  VARCHAR(50),     -- Inconsistent values and casing
    total_amount    VARCHAR(50),     -- Negative, zero, or inconsistent amounts
    status          VARCHAR(50),     -- Inconsistent status values / possible NULLs
    notes           VARCHAR(150)     -- Possible NULLs / inconsistent text
);

PRINT 'orders table created successfully.';
GO


-- ================================================================
-- CREATING ORDER_ITEMS TABLE
-- ================================================================

PRINT 'Creating order_items table...';

IF OBJECT_ID('dbo.order_items', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.order_items;
    PRINT 'Existing order_items table dropped.';
END;

CREATE TABLE order_items (
    item_id     INT PRIMARY KEY,
    order_id    INT,             -- Invalid order references / orphan records
    product_id  INT,             -- Invalid product references / orphan records
    quantity    INT,             -- Zero or negative quantities
    unit_price  VARCHAR(50),     -- Invalid values / inconsistent with product price
    discount    VARCHAR(50)      -- Negative or unrealistic discount values
);

PRINT 'order_items table created successfully.';
GO


-- ================================================================
-- TABLE CREATION COMPLETED
-- ================================================================

PRINT '================================================';
PRINT 'ALL TABLES CREATED SUCCESSFULLY.';
PRINT '================================================';
GO
