-- Get list of client who have more than 10 orders in this year.
SELECT
    client_id,
    count(order_id) AS order_count,
    strftime('%Y', date_order) AS order_year,
    strftime('%Y', 'now') AS current_year
FROM "ORDER"
WHERE strftime('%Y', date_order) = strftime('%Y', 'now')
GROUP BY client_id
HAVING order_count > 10;
