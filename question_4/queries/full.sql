-- Count number of unique client order and number of orders by order month.
SELECT
    strftime('%Y-%m', date_order) AS order_month,
    count(DISTINCT client_id) AS unique_client_count,
    count(order_id) AS total_order_count
FROM "ORDER" 
GROUP BY order_month;

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

-- From the above list of client: get information of first and second last order of client (Order date, good type, and amount)

WITH client__more_than_10_orders AS (
    SELECT
        client_id
    FROM "ORDER"
    WHERE strftime('%Y', date_order) = strftime('%Y', 'now')
    GROUP BY client_id
    HAVING count(order_id) > 10
)

, order__rank_by_date AS (
    SELECT
        o.*,
        ROW_NUMBER() OVER (
            PARTITION BY o.client_id
            ORDER BY o.date_order DESC
        ) AS rn_last
    FROM "ORDER" o
    WHERE o.client_id IN (
        SELECT client_id FROM client__more_than_10_orders
    )
)

-- Get first and second last order
SELECT * FROM order__rank_by_date
WHERE rn_last IN (1, 2);


-- Calculate total good amount and Count number of Order which were delivered in Sep.2019

WITH delivery__clean_date AS (
    SELECT
        od.*,
        -- Year
        substr(date_delivery, 8, 4) || '-' || 
        -- Month
        CASE substr(date_delivery, 4, 3)
            WHEN 'Jan' THEN '01'
            WHEN 'Feb' THEN '02'
            WHEN 'Mar' THEN '03'
            WHEN 'Apr' THEN '04'
            WHEN 'May' THEN '05'
            WHEN 'Jun' THEN '06'
            WHEN 'Jul' THEN '07'
            WHEN 'Aug' THEN '08'
            WHEN 'Sep' THEN '09'
            WHEN 'Oct' THEN '10'
            WHEN 'Nov' THEN '11'
            WHEN 'Dec' THEN '12'
            END
        -- Day
        || '-' || substr(date_delivery, 1, 2)
        AS date_delivery_clean
    FROM ORDER_DELIVERY od
)

SELECT 
    strftime('%Y-%m', date_delivery_clean) AS delivery_month,
    COUNT(od.order_id) AS total_order_count,
    SUM(o.good_amount) AS total_good_amount
FROM delivery__clean_date od
    LEFT JOIN "ORDER" o on od.order_id = o.order_id
WHERE strftime('%Y-%m', date_delivery_clean) = '2019-09'
GROUP BY delivery_month;