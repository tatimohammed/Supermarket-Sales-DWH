-- EXTRACTING THE DATA FROM POSTGRESQL DATABASE {SUPERMARKET}
-- dim_supermarket
insert into public.dim_supermarket (store_id,city,branch,gross_margin_percentage)
select s.store_id, c.city_name, b.branch_letter, s.gross_margin_percentage 
from public.sale s
join public.supermarket ss on (ss.store_id = s.store_id)
join public.city c on (c.city_id = ss.city_id)
join public.branch b on (b.branch_id = ss.branch_id);

-- dim_product
insert into public.dim_product (product_id,product_line,unit_price,quantity,tax,cogs)
select p.product_id, p.product_line, p.unit_price, s.quantity, s.tax, s.cogs
from public.sale s
join public.product p on (p.product_id = s.product_id);

-- dim_customer
insert into public.dim_customer (customer_id,customer_type,gender,payment_method,rating)
select c.customer_id, c.customer_type, c.gender, s.payment_method, s.rating
from public.sale s
join public.customer c on (c.customer_id = s.customer_id);

-- dim_date
insert into public.dim_date (day,week,month,year,hour,minute)
select 
extract(day from date) as day,
extract(week from date) as week,
extract(month from date) as month,
extract(year from date) as year,
extract(hour from time) as hour,
extract(minute from time) as minute
from public.sale;

-- fact_sales
insert into public.fact_sales (gross_income,total)
select gross_income, total 
from public.sale;