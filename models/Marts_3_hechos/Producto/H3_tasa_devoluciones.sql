WITH devoluciones AS (
    SELECT
        dp.product_id,
        COUNT(dr.return_id) as devoluciones
    FROM
        {{ ref('H3_dim_returns') }} dr
    JOIN
        {{ ref('H3_facts_orders') }} fo
    ON
        dr.order_id = fo.order_id
    JOIN
        {{ ref('H3_dim_products') }} dp
    ON
        fo.product_id = dp.product_id
    GROUP BY
        dp.product_id
),

total_producto_orders AS (
    SELECT
        dp.product_id,
        COUNT(fo.order_id) as total_ordenes
    FROM
        {{ ref('H3_facts_orders') }} fo
    JOIN
        {{ ref('H3_dim_products') }} dp
    ON
        fo.product_id = dp.product_id
    GROUP BY
        dp.product_id
),

producto_tasa_devoluciones AS (
    SELECT
        dp.product_id,
        dp.nombre_producto,
        dp.category,
        dp.precio,
        devoluciones / total_ordenes as tasa_devoluciones
    FROM devoluciones
    JOIN {{ ref('H3_dim_products') }} dp
    ON devoluciones.product_id = dp.product_id
    JOIN total_producto_orders tpo
    ON dp.product_id = tpo.product_id
    ORDER BY
        tasa_devoluciones DESC
)

SELECT * FROM producto_tasa_devoluciones