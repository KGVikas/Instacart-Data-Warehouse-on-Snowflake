-- Stage and File Format Setup
CREATE STAGE my_stage
URL='s3://snowflake-db-ecom/instacart/'
CREDENTIALS=(AWS_KEY_ID='' AWS_SECRET_KEY='');

CREATE OR REPLACE FILE FORMAT csv_file_format
TYPE='CSV'
FIELD_DELIMITER=','
SKIP_HEADER=1
FIELD_OPTIONALLY_ENCLOSED_BY='"';

-- Table Creation
CREATE TABLE aisles (
    aisle_id INT PRIMARY KEY,
    aisle VARCHAR
);

CREATE OR REPLACE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR,
    aisle_id INTEGER,
    department_id INTEGER
);

CREATE OR REPLACE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    eval_set STRING,
    order_number INTEGER,
    order_dow INTEGER,
    order_hour_of_day INTEGER,
    days_since_prior_order INTEGER
);

CREATE OR REPLACE TABLE order_products (
    order_id INTEGER,
    product_id INTEGER,
    add_to_cart_order INTEGER,
    reordered INTEGER,
    PRIMARY KEY (order_id, product_id)
);

-- Dimension Tables
CREATE OR REPLACE TABLE dim_products AS (
    SELECT product_id, product_name FROM products
);

CREATE OR REPLACE TABLE dim_users AS (
    SELECT user_id FROM orders
);

CREATE OR REPLACE TABLE dim_orders AS (
    SELECT order_id, order_number, order_dow, order_hour_of_day, days_since_prior_order FROM orders
);

CREATE OR REPLACE TABLE dim_departments AS (
    SELECT department_id, department FROM departments
);

CREATE OR REPLACE TABLE dim_aisles AS (
    SELECT aisle_id, aisle FROM aisles
);

-- Fact Table
CREATE OR REPLACE TABLE fact_order_products AS (
    SELECT 
        op.order_id,
        op.product_id,
        o.user_id,
        p.department_id,
        p.aisle_id,
        op.add_to_cart_order,
        op.reordered
    FROM order_products op
    JOIN orders o ON op.order_id = o.order_id
    JOIN products p ON op.product_id = p.product_id
);

-- Analysis Queries

-- 1. Total number of products ordered per department
SELECT 
    d.department,
    COUNT(*) AS total_products_ordered
FROM fact_order_products fop 
JOIN dim_departments d ON fop.department_id = d.department_id
GROUP BY d.department;

-- 2. Top 5 aisles with highest number of reordered products
SELECT 
    a.aisle,
    COUNT(*) AS total_reorrdered_products
FROM fact_order_products fop
JOIN dim_aisles a ON fop.aisle_id = a.aisle_id
GROUP BY a.aisle 
ORDER BY total_reorrdered_products DESC
LIMIT 5;

-- 3. Average number of products added to cart per order by day of the week
SELECT 
    o.order_dow,
    AVG(foc.add_to_cart_order) AS avg_num_of_orders_added_to_cart
FROM fact_order_products foc 
JOIN dim_orders o ON foc.order_id = o.order_id
GROUP BY o.order_dow
ORDER BY o.order_dow;

-- 4. Top 10 users with highest number of unique products ordered
SELECT 
    foc.user_id,
    COUNT(DISTINCT p.product_name) AS total_unique_products
FROM fact_order_products foc 
JOIN dim_products p ON foc.product_id = p.product_id
GROUP BY foc.user_id
ORDER BY total_unique_products DESC
LIMIT 10;
