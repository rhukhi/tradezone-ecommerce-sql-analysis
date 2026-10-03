SELECT 
    c.state, 
    COUNT(c.customer_id) AS total_new_customers,
    COUNT(o.customer_id) AS converted_customers,
    ROUND(COUNT(o.customer_id) * 100.0 / COUNT(c.customer_id), 2) AS conversion_rate
FROM customers AS c
LEFT JOIN (
    SELECT customer_id, MIN(order_date) AS first_sale
    FROM orders
    GROUP BY customer_id
) AS o 
ON c.customer_id = o.customer_id 
   AND o.first_sale <= c.signup_date + 30
WHERE c.signup_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.state
ORDER BY total_new_customers DESC
LIMIT 5;