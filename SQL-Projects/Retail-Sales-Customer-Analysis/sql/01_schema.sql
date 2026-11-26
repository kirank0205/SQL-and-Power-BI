-- PostgreSQL schema
CREATE TABLE customers (
 customer_id VARCHAR(10) PRIMARY KEY,
 customer_name VARCHAR(100) NOT NULL,
 city VARCHAR(80), region VARCHAR(30), signup_date DATE,
 acquisition_channel VARCHAR(30)
);
CREATE TABLE orders (
 order_id VARCHAR(10) PRIMARY KEY,
 customer_id VARCHAR(10) NOT NULL REFERENCES customers(customer_id),
 order_date DATE NOT NULL, region VARCHAR(30) NOT NULL,
 order_status VARCHAR(20) NOT NULL, payment_method VARCHAR(20)
);
CREATE TABLE order_items (
 order_item_id VARCHAR(10) PRIMARY KEY,
 order_id VARCHAR(10) NOT NULL REFERENCES orders(order_id),
 product_id VARCHAR(10) NOT NULL, product_name VARCHAR(100) NOT NULL,
 category VARCHAR(50) NOT NULL,
 quantity INTEGER NOT NULL CHECK (quantity > 0),
 unit_price NUMERIC(12,2) NOT NULL CHECK (unit_price >= 0),
 unit_cost NUMERIC(12,2) NOT NULL CHECK (unit_cost >= 0)
);
-- Import the three CSV files after creating these tables.
-- Example: \copy customers FROM 'customers.csv' CSV HEADER;
