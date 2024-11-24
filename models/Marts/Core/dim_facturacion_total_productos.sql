WITH f_order_items AS (
    SELECT
        foi.product_id,
        SUM(foi.quantity * dp.precio) AS total_billing
    FROM
        {{ ref('facts_order_items') }} foi
    JOIN
        {{ ref('dim_products') }} dp
    ON
        foi.product_id = dp.product_id
    GROUP BY
        foi.product_id
),
promo_distributions AS (
    SELECT
        foi.product_id,
        dpr.EUR_discount / COUNT(*) OVER (PARTITION BY fo.order_id) AS distributed_discount
    FROM
        {{ ref('facts_order_items') }} foi
    JOIN
        {{ ref('facts_orders') }} fo
    ON
        foi.order_id = fo.order_id
    JOIN
        {{ ref('dim_orders') }} dpr
    ON
        fo.order_id = dpr.order_id
    WHERE
        dpr.EUR_discount IS NOT NULL
),
f_discounts AS (
    SELECT
        product_id,
        SUM(distributed_discount) AS total_discount
    FROM
        promo_distributions
    GROUP BY
        product_id
)

SELECT
    dp.product_id,
    dp.nombre_producto,
    foi.total_billing,
    fdi.total_discount,
    foi.total_billing - fdi.total_discount AS total_billing_after_discount
FROM
    f_order_items foi
JOIN
    {{ ref('dim_products') }} dp
ON
    foi.product_id = dp.product_id
LEFT JOIN
    f_discounts fdi
ON
    dp.product_id = fdi.product_id
ORDER BY
    total_billing DESC
