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

