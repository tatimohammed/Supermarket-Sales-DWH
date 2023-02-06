-- creating Tables
CREATE TABLE customer (
    customer_id serial PRIMARY KEY,
    customer_type VARCHAR(10),
    gender VARCHAR(10)
);

CREATE TABLE product (
    product_id serial PRIMARY KEY,
    product_line VARCHAR(100),
    unit_price float
);

CREATE TABLE city (
    city_id serial PRIMARY KEY,
    city_name VARCHAR(20)
);

CREATE TABLE branch (
    branch_id serial PRIMARY KEY,
    branch_letter CHAR
);

CREATE TABLE supermarket (
    store_id serial PRIMARY KEY,
    city_id int references city(city_id),
    branch_id int references branch(branch_id)
);

CREATE TABLE sale (
    sale_id serial PRIMARY KEY,
    customer_id int references customer(customer_id),
    product_id int references product(product_id),
    store_id int references supermarket(store_id),
    quantity integer,
    tax float,
    total float,
    payment_method VARCHAR(20),
    cogs float,
    gross_margin_percentage float,
    gross_income float,
    rating float,
    date date, 
    time time
);

