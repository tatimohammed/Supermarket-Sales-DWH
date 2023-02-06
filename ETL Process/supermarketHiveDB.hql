-- Building the data warehouse
-- Creating the database
CREATE DATABASE supermarket;

-- Connect to the database
USE supermarket;

-- Creating tables
-- dim_supermarket
CREATE TABLE dim_supermarket (
    supermarket_key int,
    store_id int,
    city String,
    branch String,
    gross_margin_percentage Float,
    primary key (supermarket_key) disable novalidate
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- dim_product
CREATE TABLE dim_product (
    product_key int,
    product_id int,
    product_line String,
    unit_price Float,
    quantity int,
    tax Float,
    cogs Float,
    primary key (product_key) disable novalidate
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- dim_customer
CREATE TABLE dim_customer (
    customer_key int,
    customer_id int,
    customer_type String,
    gender String,
    payment_method String,
    rating Float,
    primary key (customer_key) disable novalidate
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- dim_date
CREATE TABLE dim_date (
    date_key int,
    day int,
    week int,
    month int,
    year int,
    hour int,
    minute int,
    primary key (date_key) disable novalidate
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- fact_sales
CREATE TABLE fact_sales (
    sale_key int,
    date_key int,
    supermarket_key int,
    product_key int,
    customer_key int,
    gross_income Float,
    total Float,
    primary key (sale_key) disable novalidate,
    CONSTRAINT fk_date FOREIGN KEY (date_key) REFERENCES dim_date(date_key) DISABLE NOVALIDATE,
    CONSTRAINT fk_customer FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key) DISABLE NOVALIDATE,
    CONSTRAINT fk_supermarket FOREIGN KEY (supermarket_key) REFERENCES dim_supermarket(supermarket_key) DISABLE NOVALIDATE,
    CONSTRAINT fk_product FOREIGN KEY (product_key) REFERENCES dim_product(product_key) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';