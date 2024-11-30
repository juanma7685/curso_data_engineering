WITH ventas_por_producto AS (
    SELECT
        foi.product_id,
        SUM(foi.quantity) AS ventas_totales
    FROM
        {{ ref('H3_facts_order_items') }} foi
    GROUP BY
        foi.product_id
)

SELECT
    dp.product_id,
    dp.nombre_producto,
    dp.inventory AS inventario_actual,
    vp.ventas_totales,
    vp.ventas_totales / NULLIF(dp.inventory, 0) AS ratio_ventas_vs_stock
FROM
    {{ ref('H3_dim_products') }} dp
LEFT JOIN
    ventas_por_producto vp
ON
    dp.product_id = vp.product_id
