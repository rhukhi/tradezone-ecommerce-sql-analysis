SELECT 
    c.state,
    p.payment_method,
    COUNT(p.payment_id) AS transaction_count,
    SUM(p.amount) AS total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.state, p.payment_method
ORDER BY c.state ASC, transaction_count DESC;