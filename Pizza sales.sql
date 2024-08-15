CREATE TABLE Pizza_tb(
	pizza_id int8 PRIMARY KEY,
	order_id int8,
	pizza_name_id varchar(100),
	quantity numeric(20),
	order_date date,
	order_time time,
	unit_price dec(10,2),
	total_price dec(10,2),
	pizza_size varchar(100),
	pizza_category varchar(100),
	pizza_ingredients varchar(300),
	pizza_name varchar(100))
	
SELECT*FROM Pizza_tb

1--total revenue 
SELECT SUM(total_price) AS total_revenue 
FROM Pizza_tb

2-- Average order value 
SELECT SUM(total_price)/COUNT(DISTINCT(order_id)) AS Avg_order 
FROM Pizza_tb

3-- Total Pizzas Sold 
SELECT SUM(quantity) AS Total_Pi_Sold 
FROM Pizza_tb

4 -- Total orders 
SELECT COUNT(DISTINCT(order_id)) AS Total_order 
FROM Pizza_tb

5-- Average Pizzaa Per Order 
SELECT SUM(quantity)/COUNT(DISTINCT(order_id)) AS Avg_Pi_Per_order 
FROM Pizza_tb

--Chart requerments 
1-- Daily trands for total order 
SELECT TO_CHAR(order_date,'Day') AS order_day, COUNT(DISTINCT(order_id)) AS total_order 
FROM Pizza_tb
GROUP BY TO_CHAR(order_date,'Day')

2-- Monthely trend for the total order 

SELECT TO_CHAR(order_date, 'Month') AS month_name, COUNT(DISTINCT(order_id)) AS total_order
FROM Pizza_tb
GROUP BY TO_CHAR(order_date, 'Month')
ORDER BY total_order DESC 

3-- percentage of the sales for the pizza catogery 

WITH Total_Sales AS (
    SELECT SUM(total_price) AS total_price_sum
    FROM Pizza_tb
    WHERE EXTRACT(MONTH FROM order_date) = 1
)
SELECT 
    pizza_size, 
    SUM(total_price) * 100.0 / Total_Sales.total_price_sum AS percentage 
FROM 
    Pizza_tb, Total_Sales 
WHERE 
    EXTRACT(MONTH FROM order_date) = 1
GROUP BY 
    pizza_size, Total_Sales.total_price_sum
ORDER BY
    percentage DESC;

6--Top 5 best selling Pizzas
SELECT pizza_name, SUM(total_price) AS total_Order FROM Pizza_tb
GROUP BY pizza_name
ORDER BY total_Order DESC 
LIMIT 5;

7-- worst selling Pizzas
SELECT pizza_name, SUM(total_price) AS total_Order FROM Pizza_tb
GROUP BY pizza_name
ORDER BY total_Order ASC 
LIMIT 5;










