-- Create the landing table
CREATE TABLE landing (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    address VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);

-- Create the staging table
CREATE TABLE staging (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    address VARCHAR(255),
    created_at DATETIME,
    is_valid BIT,
    transformed_at DATETIME DEFAULT GETDATE()
);

-- Create the production table
CREATE TABLE prod (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    address VARCHAR(255),
    created_at DATETIME,
    updated_at DATETIME DEFAULT GETDATE()
);

-- Insert data into landing table
INSERT INTO landing (id, name, email, phone, address, created_at) VALUES
(1, 'Alice', 'alice@example.com', '555-1234', '123 Main St', '2023-07-20 10:00:00'),
(2, 'Bob', 'bob@domain.com', '555-5678', '456 Elm St', '2023-07-21 11:00:00'),
(3, 'Charlie', 'invalidemail.com', '555-8765', '789 Oak St', '2023-07-22 12:00:00'),
(4, 'David', 'david@example.com', '555-4321', '101 Pine St', '2023-07-23 13:00:00'),
(5, 'Eve', 'eve@example.com', '555-6789', '202 Birch St', '2023-07-24 14:00:00');

-- Insert data into staging table
INSERT INTO staging (id, name, email, phone, address, created_at, is_valid, transformed_at) VALUES
(1, 'Alice', 'alice@example.com', '555-1234', '123 Main St', '2023-07-20 10:00:00', 1, '2023-07-20 11:00:00'),
(2, 'Bob', 'bob@domain.com', '555-5678', '456 Elm St', '2023-07-21 11:00:00', 1, '2023-07-21 12:00:00'),
(3, 'Charlie', 'invalidemail.com', '555-8765', '789 Oak St', '2023-07-22 12:00:00', 0, '2023-07-22 13:00:00'),
(4, 'David', 'david@example.com', '555-4321', '101 Pine St', '2023-07-23 13:00:00', 1, '2023-07-23 14:00:00');

-- Insert data into production table
INSERT INTO prod (id, name, email, phone, address, created_at, updated_at) VALUES
(1, 'Alice', 'alice@example.com', '555-1234', '123 Main St', '2023-07-20 10:00:00', '2023-07-20 11:00:00'),
(2, 'Bob', 'bob@domain.com', '555-5678', '456 Elm St', '2023-07-21 11:00:00', '2023-07-21 12:00:00'),
(3, 'Charlie', 'invalidemail.com', '555-8765', '789 Oak St', '2023-07-22 12:00:00', '2023-07-22 13:00:00'),
(4, 'David', 'david@example.com', '555-4321', '101 Pine St', '2023-07-23 13:00:00', '2023-07-23 14:00:00'),
(5, 'Eve', 'eve@example.com', '555-6789', '202 Birch St', '2023-07-24 14:00:00', '2023-07-24 15:00:00');

-- Query to check landing to staging row count
SELECT 'Check landing to staging row count' AS RuleUnderTest,
       'landing to staging' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM landing) = (SELECT COUNT(*) FROM staging) THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check email validity in staging
SELECT 'Check email validity in staging' AS RuleUnderTest,
       'staging' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging WHERE email NOT LIKE '%@%') = 0 THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check is_valid flag in staging
SELECT 'Check is_valid flag in staging' AS RuleUnderTest,
       'staging' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging WHERE is_valid = 0) = 0 THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check staging to production row count
SELECT 'Check staging to production row count' AS RuleUnderTest,
       'staging to production' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging) = (SELECT COUNT(*) FROM prod) THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check created_at timestamp consistency
SELECT 'Check created_at timestamp consistency' AS RuleUnderTest,
       'staging to production' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging s JOIN prod p ON s.id = p.id WHERE s.created_at != p.created_at) = 0 THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check updated_at timestamp in production
SELECT 'Check updated_at timestamp in production' AS RuleUnderTest,
       'production' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM prod WHERE updated_at > DATEADD(minute, -1, CURRENT_TIMESTAMP)) = (SELECT COUNT(*) FROM prod) THEN 'PASS' ELSE 'FAIL' END AS TestResult;
