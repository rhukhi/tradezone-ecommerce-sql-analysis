SELECT 
    s.seller_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(r.rating), 1) AS avg_rating,
    SUM(o.total_amount) AS total_revenue
FROM sellers s
JOIN orders o ON s.seller_id = o.seller_id
JOIN reviews r ON o.order_id = r.order_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY s.seller_name
HAVING COUNT(o.order_id) >= 10 
   AND AVG(r.rating) >= 4.0
ORDER BY total_revenue DESC
LIMIT 10;