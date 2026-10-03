SELECT 
    EXTRACT(YEAR FROM order_date) AS revenue_year,
    EXTRACT(QUARTER FROM order_date) AS revenue_quarter,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2024-12-31'
GROUP BY revenue_year, revenue_quarter
ORDER BY revenue_year, revenue_quarter;