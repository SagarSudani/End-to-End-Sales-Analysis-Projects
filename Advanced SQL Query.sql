
## Previous Month and Current Month Total Sales with Increase Percentage  ##WINDOW FUNCTION LAC
WITH monthly_sales AS (                                  
  SELECT 
    MONTH(transaction_date) AS month,                            
    SUM(unit_price * transaction_qty) AS total_sales          -- total sales 
  FROM coffeeshopsales
  WHERE MONTH(transaction_date) IN (4,5)      -- for month april(pm) and may (cm)
  GROUP BY MONTH(transaction_date)
)
SELECT 
  month,
  total_sales,
  ROUND(
    (total_sales - LAG(total_sales) OVER (ORDER BY month))                
    / LAG(total_sales) OVER (ORDER BY month) * 100, 2        -- percentage increase previous month
  ) AS increase_percentage
FROM monthly_sales
ORDER BY month;


 # Weekdays and Weekend Total sales
 SELECT 
	case when dayofweek(transaction_date) in (1,7) then 'weekend'
	else 'weekdays'
	end as day_type,
	concat(round(sum(unit_price * transaction_qty)/1000,1),'K') as total_sales
 from coffeeshopsales
 where month(transaction_date) = 5
 group by
 case when dayofweek(transaction_date) in (1,7) then 'weekend'
 else 'weekdays'
 end;
select 
	concat(round(avg(total_sales)/1000,1),'K') as avg_sales
    from(
    select sum(unit_price * transaction_qty) as total_sales
    from coffeeshopsales
    where 
    month(transaction_date) = 4
    group by transaction_date
    ) as internal_query


# Sales status and Total sales By each day of month
select 
day_of_month,
case
when total_sales > avg_sales then 'above average'
when total_sales < avg_sales then 'below average'
else 'average'
end as sales_status,
total_sales
from (
select
sum(unit_price * transaction_qty) as total_sales,
day(transaction_date) as day_of_month,
avg(sum(unit_price * transaction_qty)) over() as avg_sales 
from coffeeshopsales
where
 month(transaction_date) = 5
 group by day(transaction_date)
) as sales_data
order by day_of_month ;

# Time Serial Analysis
select 
count(*) as total_orders,
sum(unit_price * transaction_qty) as total_sales,
sum(transaction_qty) as total_sold_qty
from coffeeshopsales
where
month(transaction_date) = 5   -- may
and day(transaction_date) = 1 -- monday..sunday (1,...,7) 
and hour(transaction_time) = 16 -- 24hour format

#Hourly total sales 
SELECT
	hour(transaction_time),
	sum(unit_price * transaction_qty) as total_sales
from coffeeshopsales
where month(transaction_date) = 5   -- may
group by hour (transaction_time)
order by hour (transaction_time) 

# Weekly Total sales
SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffeeshopsales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END;

## Total Orders by previous month and current month with increase percentage
WITH monthly_sales AS (                                  
  SELECT 
    MONTH(transaction_date) AS month,                            
    count(transaction_id) AS total_orders          -- total orders 
  FROM coffeeshopsales
  WHERE MONTH(transaction_date) IN (4,5)      -- for month april(pm) and may (cm)
  GROUP BY MONTH(transaction_date)
)
SELECT 
  month,
  total_orders,
  ROUND(
    (total_orders - LAG(total_orders) OVER (ORDER BY month))                
    / LAG(total_orders) OVER (ORDER BY month) * 100, 2        
  ) AS increase_percentage
FROM monthly_sales
ORDER BY month;


# Total Quantity sold by previous month and current month with increase percentage
WITH monthly_sales AS (                                  
  SELECT 
    MONTH(transaction_date) AS month,                            
    sum(transaction_qty) AS total_quantity_sold          -- total orders 
  FROM coffeeshopsales
  WHERE MONTH(transaction_date) IN (4,5)      -- for month april(pm) and may (cm)
  GROUP BY MONTH(transaction_date)
)
SELECT 
  month,
  total_quantity_sold,
  ROUND(
    (total_quantity_sold - LAG(total_quantity_sold) OVER (ORDER BY month))                
    / LAG(total_quantity_sold) OVER (ORDER BY month) * 100, 2        
  ) AS increase_percentage
FROM monthly_sales
ORDER BY month;
