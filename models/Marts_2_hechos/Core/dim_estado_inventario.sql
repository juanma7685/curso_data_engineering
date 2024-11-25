WITH estado_inventario AS (
    WITH ventas_por_producto AS (
        SELECT
            foi.product_id,
            SUM(foi.quantity) AS ventas_totales
        FROM
            {{ ref('facts_orders') }} foi
        GROUP BY
            foi.product_id
    )
    SELECT
        dp.product_id,
        dp.nombre_producto,
        COALESCE(dp.inventory, 0) AS inventario_actual,
        COALESCE(vp.ventas_totales, 0) AS ventas_totales,
        COALESCE(dp.inventory, 0) - COALESCE(vp.ventas_totales, 0) AS inventario_disponible,
        COALESCE(vp.ventas_totales, 0) / NULLIF(COALESCE(dp.inventory, 0), 0) AS ratio_ventas_vs_stock
    FROM
        {{ ref('dim_products') }} dp
    LEFT JOIN
        ventas_por_producto vp
    ON
        dp.product_id = vp.product_id
)

SELECT * FROM estado_inventario
