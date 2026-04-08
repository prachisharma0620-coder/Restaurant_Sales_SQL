-- CREATE DATABASE retail_analysis;
-- USE retail_analysis;

-- CREATE TABLE online_retail (
--     InvoiceNo     VARCHAR(20),
--     StockCode     VARCHAR(20),
--     Description   VARCHAR(255),
--     Quantity      INT,
--     InvoiceDate   DATETIME,
--     UnitPrice     DECIMAL(10,2),
--     CustomerID    VARCHAR(20),
--     Country       VARCHAR(100)
-- );

-- Checking business performance over the years

-- Uploaded the data using wizard

-- 
-- QUERY: Calculate the orders by month
select MONTH(order_date) AS order_month, 
COUNT(DISTINCT order_id) AS orders
FROM order_details
GROUP BY order_month;

-- QUERY: Which customers are repeating customers

SELECT order_id, COUNT(*) AS rep_customer
FROM order_details
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY rep_customer DESC;

-- order id: 330, 440, 443, 1957, 2675, 3473, 4305, 4482 ordered 14 times. We can run coupons for them.

-- QUERY: Which customer ordered which category by joining menu_item and order_details and query the most famous item

WITH mostItems AS (
SELECT od.order_details_id, mi.item_name, mi.price
FROM order_details od
JOIN menu_items mi
ON od.item_id = mi.menu_item_id)

SELECT item_name, COUNT(*) AS MostFav
FROM mostItems
GROUP BY item_name
ORDER BY MostFav DESC;   -- Hamburger, Edamame, Korean BeefBowl came out to be the top fav dishes. Could've used limit

-- QUERY: Dates with most orders 
SELECT order_date, COUNT(*) AS most_ordered
FROM order_details
GROUP BY order_date
ORDER BY most_ordered DESC;   -- 1st Feb was most ordered day

-- QUERY: Month with most orders
SELECT MONTH(order_date) as Month_D, COUNT(*) AS most_ordered
FROM order_details
GROUP BY Month_D
ORDER BY most_ordered DESC; -- March was the best month for orders

-- QUERY: Lets calculate the revenue for each month
WITH CTE AS(
SELECT od.order_details_id, od.item_id, od.order_date, mi.price
FROM order_details od
JOIN menu_items mi
ON od.item_id = mi.menu_item_id)

SELECT MONTH(order_date) AS Mnth, SUM(price) AS rev
FROM CTE
GROUP BY Mnth
ORDER BY rev DESC;  -- March was most profitable with 54,610 as rev

-- QUERY: Revenue by Category
WITH CTE AS(
SELECT od.item_id, mi.category, mi.price
FROM order_details od
JOIN menu_items mi
ON od.item_id = mi.menu_item_id)

SELECT category, SUM(price) as categ_Rev
FROM CTE
GROUP BY category
ORDER BY categ_Rev DESC;    -- Italian topped the list with Italian, followed by Asian, Mexican, American

-- QUERY: Least popular items
WITH mostItems AS (
SELECT od.order_details_id, mi.item_name, mi.price
FROM order_details od
JOIN menu_items mi
ON od.item_id = mi.menu_item_id)

SELECT item_name, COUNT(*) AS MostFav
FROM mostItems
GROUP BY item_name
ORDER BY LeastFav ASC;      -- Chicken Tacos is least ordered item, can reduce inventory for the same.alter

-- QUERY: Average revenue per month
WITH CTE AS(
SELECT od.order_details_id, od.item_id, od.order_date, mi.price
FROM order_details od
JOIN menu_items mi
ON od.item_id = mi.menu_item_id)

SELECT MONTH(order_date) AS Mnth, AVG(price) AS avg_rev
FROM CTE
GROUP BY Mnth
ORDER BY avg_rev DESC;    -- Average revenue for all months came out to be around 13.

-- Query: Priciest Item on the menu
SELECT item_name, price
FROM menu_items
ORDER BY price DESC;     -- Shrimp is the costliest and Edamame is cheapest

-- QUERY: Customer acquired per month
SELECT MONTH(order_date) AS mnth, COUNT( DISTINCT order_id ) as Dis_cust
FROM order_details
GROUP BY mnth
ORDER BY Dis_cust DESC;     -- Jan saw most new customers, followed by march and feb.alter

-- QUERY: Busiest Hours of the day
SELECT order_time, COUNT(*) AS bus_t
FROM order_details
GROUP BY order_time
HAVING bus_t > 10
ORDER BY order_time DESC;       -- 11:49 came out to be the time when most orders were placed, A range would be 11:45 to 3:00 pm

-- Query: Revenue Rank by Category
WITH cte AS
(SELECT mi.category, mi.item_name, COUNT(od.order_details_id) as Times_order, SUM(mi.price) AS rev
FROM order_details od
JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY mi.category, mi.item_name)

SELECT 
category, item_name, Times_order, rev,
RANK () OVER ( PARTITION BY category ORDER BY rev DESC ) AS Rank_Categ 
FROM cte;         -- 1st in American: cheeseburger, Asian: Korean Beef Bowl, Italian: Spaghetti, Mexican: Steak Torta

-- QUERY: Running total revenue by month
WITH CTE as (
SELECT od.order_date,
SUM(mi.price) AS daily_revenue
FROM order_details od
JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY od.order_date
)
SELECT 
    order_date,
    daily_revenue,
    ROUND(SUM(daily_revenue) OVER (PARTITION BY MONTH(order_date) ORDER BY order_date), 2) AS running_total
FROM CTE
ORDER BY order_date;

























