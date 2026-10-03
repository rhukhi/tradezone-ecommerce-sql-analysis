DELETE FROM orders 
WHERE order_id IN (
    SELECT order_id FROM (
        SELECT order_id, ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY order_date) as row_num 
        FROM orders
    ) t WHERE t.row_num > 1
);


UPDATE orders 
SET delivery_date = order_date + INTERVAL '5 days' 
WHERE order_status = 'Delivered' AND delivery_date IS NULL;

UPDATE products SET category = 'Uncategorized' WHERE category IS NULL;

ALTER TABLE order_items ALTER COLUMN unit_price TYPE NUMERIC(10,2);
ALTER TABLE order_items ALTER COLUMN line_total TYPE NUMERIC(10,2);

UPDATE customers SET first_name = TRIM(first_name), last_name = TRIM(last_name), state = TRIM(state);
UPDATE products SET product_name = TRIM(product_name), category = TRIM(category);
UPDATE payments SET payment_method = TRIM(payment_method);

UPDATE order_items 
SET line_total = ROUND(quantity * unit_price, 2)
WHERE line_total IS NULL OR line_total != ROUND(quantity * unit_price, 2);

DELETE FROM orders WHERE order_date > CURRENT_DATE;