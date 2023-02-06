-- Staging the data in the postgres database for the ETL process

-- Creating tables
-- dim_supermarket
CREATE TABLE dim_supermarket (
    supermarket_key serial PRIMARY KEY,
    store_id int,
    city VARCHAR(100),
    branch CHAR,
    gross_margin_percentage Float
);

-- dim_product
CREATE TABLE dim_product (
    product_key serial PRIMARY KEY,
    product_id int,
    product_line VARCHAR(100),
    unit_price Float,
    quantity int,
    tax Float,
    cogs Float
);

-- dim_customer
CREATE TABLE dim_customer (
    customer_key serial PRIMARY KEY,
    customer_id int,
    customer_type VARCHAR(100),
    gender VARCHAR(100),
    payment_method VARCHAR(100),
    rating Float
);

-- dim_date
CREATE TABLE dim_date (
    date_key serial PRIMARY KEY,
    day int,
    week int,
    month int,
    year int,
    hour int,
    minute int
);

-- fact_sales
CREATE TABLE fact_sales (
    sale_key serial PRIMARY KEY,
    date_key serial,
    supermarket_key serial,
    product_key serial,
    customer_key serial,
    gross_income Float,
    total Float,
    CONSTRAINT fk_date FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    CONSTRAINT fk_customer FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    CONSTRAINT fk_supermarket FOREIGN KEY (supermarket_key) REFERENCES dim_supermarket(supermarket_key),
    CONSTRAINT fk_product FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);