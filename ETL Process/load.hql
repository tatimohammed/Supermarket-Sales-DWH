-- Select the database
use supermarket;

-- Loading the data into Hive DWH
-- customer
load data local inpath '/home/tati/Supermarket-DWH/customer-data.csv' into table dim_customer;

-- date
load data local inpath '/home/tati/Supermarket-DWH/date-data.csv' into table dim_date;

-- product
load data local inpath '/home/tati/Supermarket-DWH/product-data.csv' into table dim_product;

-- supermarket
load data local inpath '/home/tati/Supermarket-DWH/supermarket-data.csv' into table dim_supermarket;

-- sales
load data local inpath '/home/tati/Supermarket-DWH/sales-data.csv' into table fact_sales;