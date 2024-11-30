WITH facturacion_por_categoria AS (
    SELECT
        dp.category,
        SUM(dp.precio * hfoi.quantity) AS total_facturado
    FROM
        {{ ref('H3_facts_order_items') }} hfoi
    JOIN
        {{ ref('H3_dim_products') }} dp
    ON
        hfoi.product_id = dp.product_id
    GROUP BY dp.category
),
categoria_max_facturacion AS (
    SELECT
        category,
        total_facturado
    FROM facturacion_por_categoria
    ORDER BY total_facturado DESC
    LIMIT 1
)
SELECT * FROM categoria_max_facturacion