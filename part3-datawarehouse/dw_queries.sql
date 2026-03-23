-- Q1: Total sales revenue by product category for each month
SELECT
    d.year_num,
    d.month_num,
    d.month_name,
    p.category,
    SUM(f.total_sales) AS total_sales_revenue
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
JOIN dim_product p
    ON f.product_id = p.product_id
GROUP BY d.year_num, d.month_num, d.month_name, p.category
ORDER BY d.year_num, d.month_num, p.category;

-- Q2: Top 2 performing stores by total revenue
SELECT
    s.store_name,
    s.store_city,
    SUM(f.total_sales) AS total_sales_revenue
FROM fact_sales f
JOIN dim_store s
    ON f.store_id = s.store_id
GROUP BY s.store_name, s.store_city
ORDER BY total_sales_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
WITH monthly_sales AS (
    SELECT
        d.year_num,
        d.month_num,
        d.month_name,
        SUM(f.total_sales) AS monthly_sales
    FROM fact_sales f
    JOIN dim_date d
        ON f.date_id = d.date_id
    GROUP BY d.year_num, d.month_num, d.month_name
)
SELECT
    year_num,
    month_num,
    month_name,
    monthly_sales,
    LAG(monthly_sales) OVER (ORDER BY year_num, month_num) AS previous_month_sales,
    monthly_sales - LAG(monthly_sales) OVER (ORDER BY year_num, month_num) AS absolute_change
FROM monthly_sales
ORDER BY year_num, month_num;
