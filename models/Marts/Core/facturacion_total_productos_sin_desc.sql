
WITH order_items AS (
    SELECT
        dp.product_id,
        SUM(quantity * precio) AS total_billing
    FROM
        {{ ref('facts_order_items') }} foi
    JOIN
        {{ ref('dim_products') }} dp
    ON
        foi.product_id = dp.product_id
    GROUP BY
        dp.product_id
)

SELECT
    dp.product_id,
    dp.nombre_producto,
    oi.total_billing
FROM
    order_items oi
JOIN
    {{ ref('dim_products') }} dp
ON
    oi.product_id = dp.product_id
ORDER BY
    total_billing DESC