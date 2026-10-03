SELECT 
    CASE 
        WHEN total_spent >= 100000 THEN 'High Spenders'
        WHEN total_spent BETWEEN 50000 AND 99999 THEN 'Medium Spenders'
        ELSE 'Low Spenders'
    END AS spend_group,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(total_spent), 2) AS avg_spend_per_customer,
    SUM(total_spent) AS total_revenue_contribution
FROM (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY customer_id
) AS customer_totals
GROUP BY spend_group;