WITH NewCustomers AS (
    SELECT 
        customer_id, 
        state, 
        signup_date
    FROM customers
    WHERE EXTRACT(YEAR FROM signup_date) = 2024
),
Purchasers AS (
    SELECT DISTINCT 
        o.customer_id
    FROM orders o
    JOIN NewCustomers nc ON o.customer_id = nc.customer_id
    WHERE o.order_date <= (nc.signup_date + INTERVAL '30 days')
)
SELECT 
    nc.state,
    COUNT(nc.customer_id) AS total_new_signups,
    ROUND(COUNT(p.customer_id) * 100.0 / COUNT(nc.customer_id), 1) AS conversion_rate_pct
FROM NewCustomers nc
LEFT JOIN Purchasers p ON nc.customer_id = p.customer_id
GROUP BY nc.state
ORDER BY total_new_signups DESC
LIMIT 5;