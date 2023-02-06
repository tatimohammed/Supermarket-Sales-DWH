-- making backup data to put on the HDFS later
-- customer CSV
\copy public.dim_customer TO 'Supermarket-DWH-Backup/customer-data.csv' DELIMITER ',' CSV HEADER;

-- date CSV
\copy public.dim_date TO 'Supermarket-DWH-Backup/date-data.csv' DELIMITER ',' CSV HEADER;

-- product CSV
\copy public.dim_product TO 'Supermarket-DWH-Backup/product-data.csv' DELIMITER ',' CSV HEADER;

-- supermarket CSV
\copy public.dim_supermarket TO 'Supermarket-DWH-Backup/supermarket-data.csv' DELIMITER ',' CSV HEADER;

-- sales CSV
\copy public.fact_sales TO 'Supermarket-DWH-Backup/sales-data.csv' DELIMITER ',' CSV HEADER;


-- The data that we will put on the data warehouse (we need to export it without headers)
-- customer TABLE
\copy public.dim_customer TO 'Supermarket-DWH/customer-data.csv' DELIMITER ',' CSV;

-- date TABLE
\copy public.dim_date TO 'Supermarket-DWH/date-data.csv' DELIMITER ',' CSV;

-- product TABLE
\copy public.dim_product TO 'Supermarket-DWH/product-data.csv' DELIMITER ',' CSV;

-- supermarket TABLE
\copy public.dim_supermarket TO 'Supermarket-DWH/supermarket-data.csv' DELIMITER ',' CSV;

-- sales TABLE
\copy public.fact_sales TO 'Supermarket-DWH/sales-data.csv' DELIMITER ',' CSV;