WITH facturacion_por_categoria AS (
    SELECT
        dp.category,
        SUM(dp.precio * fo.quantity) AS total_facturado,
        SUM(fo.quantity) AS total_vendido
    FROM
        {{ ref('facts_orders') }} fo
    JOIN
        {{ ref('dim_products') }} dp
    ON
        fo.product_id = dp.product_id
    GROUP BY dp.category
),
categoria_max_facturacion AS (
    SELECT
        category,
        total_facturado,
        total_vendido
    FROM facturacion_por_categoria
    ORDER BY total_facturado DESC
)
SELECT * FROM categoria_max_facturacion