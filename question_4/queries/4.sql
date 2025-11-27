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
GROUP BY delivery_month
