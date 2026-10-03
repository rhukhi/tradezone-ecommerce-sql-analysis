SELECT 
    CASE 
        WHEN avg_rating >= 4.0 THEN 'High Rated'
        WHEN avg_rating BETWEEN 3.0 AND 3.99 THEN 'Mid Rated'
        ELSE 'Low Rated'
    END AS rating_category,
    COUNT(product_id) AS product_count,
    SUM(total_revenue) AS total_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM (
    SELECT 
        p.product_id, 
        AVG(r.rating) AS avg_rating, 
        SUM(oi.line_total) AS total_revenue,
        AVG(oi.unit_price) AS unit_price
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    LEFT JOIN reviews r ON oi.order_id = r.order_id
    GROUP BY p.product_id
) AS product_stats
GROUP BY rating_category;