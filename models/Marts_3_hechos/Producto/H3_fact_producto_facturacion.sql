WITH facturacion_por_producto AS (
    SELECT
        dp.category,
        dp.product_id,
        SUM(dp.precio * hfoi.quantity) AS total_facturado
    FROM
        {{ ref('H3_facts_order_items') }} hfoi
    JOIN
        {{ ref('H3_dim_products') }} dp
    ON
        hfoi.product_id = dp.product_id
    GROUP BY
        dp.category, dp.product_id
),
producto_max_facturacion AS (
    SELECT
        category,
        product_id,
        total_facturado
    FROM (
        SELECT
            category,
            product_id,
            total_facturado,
            RANK() OVER (PARTITION BY category ORDER BY total_facturado DESC) AS posicion
        FROM facturacion_por_producto
    ) WHERE posicion = 1
)
SELECT * FROM producto_max_facturacion