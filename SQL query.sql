SELECT * FROM coffee_sales.coffeeshopsales

UPDATE coffeeshopsales
SET transaction_date = STR_TO_DATE(transaction_date, '%d/%m/%Y');

ALTER TABLE coffeeshopsales
MODIFY COLUMN transaction_date date;

UPDATE coffeeshopsales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s');

ALTER TABLE coffeeshopsales
MODIFY COLUMN transaction_time time;

describe coffeeshopsales

#Total sales by month
SELECT SUM(unit_price * transaction_qty) AS total_sales                  -- Total sales by Month
FROM coffeeshopsales
WHERE MONTH(transaction_date) = 5;

#Total orders by month
select count(transaction_id) as total_order                            -- Monthly order 
from coffeeshopsales
where 
month(transaction_date)=3

#Total Quantity sold by month
select sum(transaction_qty) as total_qty_sold              -- monthly quantity sold
from coffeeshopsales
where
month(transaction_date) = 6

#Total sales,Quantity nand Orders by Transaction Date
select 
concat(ROUND(sum(unit_price * transaction_qty)/1000,1),'K') as total_sales,
concat(round(SUM(transaction_qty)/1000,1),'K') as total_qty_sold,
concat(round(COUNT(transaction_id)/1000,1),'K') as total_orders
 from coffeeshopsales
 where transaction_date = '2023/05/18'

 #Avarage sale by month
 select avg(unit_price * transaction_qty) as avg_sales
 from coffeeshopsales
 where
 month(transaction_date) = 5

#total sale by each day of month
    select day(transaction_date) as day_of_month,
    sum(unit_price * transaction_qty) as totol_sales
    from coffeeshopsales
	where 
    month(transaction_date) = 5
    group by day (transaction_date)
    order by day (transaction_date)

#Total_sales by product
select product_category,
sum(unit_price * transaction_qty) as total_sales
from coffeeshopsales
where
	month(transaction_date) = 5
    group by product_category

#Top 5 product type 
select product_type,
sum(unit_price * transaction_qty) as total_sales
from coffeeshopsales
where
	month(transaction_date) = 5
    group by product_type
    order by total_sales desc
    limit 5;

#Top 5 tea sales 
select product_type,
sum(unit_price * transaction_qty) as total_sales
from coffeeshopsales
where
	month(transaction_date) = 5 and product_category = 'tea'
    group by product_type
    order by total_sales desc
    limit 5;
