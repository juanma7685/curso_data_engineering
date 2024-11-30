
WITH facturacion_por_producto AS (
    SELECT
        dp.product_id,
        SUM(dp.precio * fo.quantity) AS total_facturado,
        SUM(fo.quantity) AS total_vendido
    FROM
        {{ ref('facts_orders') }} fo
    JOIN
        {{ ref('dim_products') }} dp
    ON
        fo.product_id = dp.product_id
    GROUP BY
        dp.product_id
),
producto_max_facturacion AS (
    SELECT
        dp.product_id,
        dp.nombre_producto,
        dp.category,
        dp.precio,
        total_facturado,
        total_vendido
        FROM facturacion_por_producto
        JOIN {{ ref('dim_products') }} dp
        ON facturacion_por_producto.product_id = dp.product_id
    ORDER BY
        total_facturado DESC
)
SELECT * FROM producto_max_facturacion