-- Count number of unique client order and number of orders by order month.
SELECT
    strftime('%Y-%m', date_order) AS order_month,
    count(DISTINCT client_id) AS unique_client_count,
    count(order_id) AS total_order_count
FROM "ORDER" 
GROUP BY order_month;
