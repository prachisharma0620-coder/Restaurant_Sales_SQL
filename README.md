# 🍽️ Restaurant Order Analysis — SQL Case Study

## Project Overview
Analysed restaurant order data using MySQL to uncover 
business insights on revenue trends, popular menu items, 
and peak ordering patterns.

## Dataset
Two tables — `menu_items` (32 items across 4 categories) 
and `order_details` (12,000+ orders)

## Tools Used
- MySQL (Workbench + PopSQL)
- SQL Concepts: JOINs, CTEs, Window Functions, 
  RANK(), PARTITION BY, Running Totals, Aggregate Functions

## Key Business Insights
- 🍔 **Top selling items:** Hamburger, Edamame, Korean Beef Bowl
- 📅 **Busiest day:** 1st February had the highest order volume
- 🏆 **Top item by category:**
  - American → Cheeseburger
  - Asian → Korean Beef Bowl
  - Italian → Spaghetti
  - Mexican → Steak Torta
- 💰 **Highest revenue category:** Italian → Asian → Mexican → American
- 📈 **Running total** tracked to monitor cumulative revenue growth
- 🥳**Customer Favourite** Hamburger, Edamame, Korean BeefBowl
- 😖**Least Ordered** Chicken Tacos
- *️⃣**Average Revenue Per month** Around 13 for every month
- 🔉**Distinct Customers Acquired Per Month** January: 1845, March: 1840, February: 1685 (In Decreasing Order)

## Queries Covered
| # | Query | Concepts Used |
|---|---|---|
| 1 | Basic order + item details | JOIN |
| 2 | Total revenue | SUM, JOIN |
| 3 | Revenue by category | GROUP BY, aggregates |
| 4 | Top 10 best selling items | ORDER BY, LIMIT |
| 5 | Least popular items | ASC sort |
| 6 | Daily revenue trend | DATE, GROUP BY |
| 7 | Busiest hours | HOUR(), GROUP BY |
| 8 | High value orders | CTE, subquery |
| 9 | Revenue rank by category | CTE, PARTITION BY, RANK() |
| 10 | Running total of revenue | Window Function, SUM OVER |
