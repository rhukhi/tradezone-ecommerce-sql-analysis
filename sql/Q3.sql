SELECT 
    s.seller_name, 
    COUNT(o.order_id) AS total_completed_orders,
    ROUND(AVG(o.delivery_date - o.order_date) * 24, 1) AS avg_fulfillment_hours,
    ROUND(AVG(r.rating), 1) AS avg_customer_rating
FROM sellers AS s
JOIN orders AS o ON s.seller_id = o.seller_id
LEFT JOIN reviews AS r ON o.order_id = r.order_id
WHERE o.order_status = 'Delivered' 
  AND o.delivery_date IS NOT NULL
GROUP BY s.seller_name
HAVING COUNT(o.order_id) >= 20
ORDER BY avg_fulfillment_hours ASC
LIMIT 20;