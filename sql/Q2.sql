SELECT 
    p.product_name,
    p.category,
    SUM(oi.line_total) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
	AND oi.line_total IS NOT NULL
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;