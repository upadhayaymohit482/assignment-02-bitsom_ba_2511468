-- Q1: List all customers from Mumbai along with their total order value
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(p.unit_price * oi.quantity), 0) AS total_order_value
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
LEFT JOIN OrderItems oi
    ON o.order_id = oi.order_id
LEFT JOIN Products p
    ON oi.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_order_value DESC, c.customer_name;

-- Q2: Find the top 3 products by total quantity sold
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM Products p
JOIN OrderItems oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC, p.product_name
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT
    s.sales_rep_id,
    s.sales_rep_name,
    COUNT(DISTINCT o.customer_id) AS unique_customers_handled
FROM SalesReps s
LEFT JOIN Orders o
    ON s.sales_rep_id = o.sales_rep_id
GROUP BY s.sales_rep_id, s.sales_rep_name
ORDER BY unique_customers_handled DESC, s.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT
    o.order_id,
    c.customer_name,
    SUM(p.unit_price * oi.quantity) AS total_order_value
FROM Orders o
JOIN Customers c
    ON o.customer_id = c.customer_id
JOIN OrderItems oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
GROUP BY o.order_id, c.customer_name
HAVING SUM(p.unit_price * oi.quantity) > 10000
ORDER BY total_order_value DESC, o.order_id;

-- Q5: Identify any products that have never been ordered
SELECT
    p.product_id,
    p.product_name
FROM Products p
LEFT JOIN OrderItems oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_id;
