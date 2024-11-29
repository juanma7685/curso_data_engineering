WITH ventas_por_categoria AS (
    SELECT
        dp.category,
        SUM(hfoi.quantity) AS total_vendido
    FROM
        {{ ref('H3_facts_order_items') }} hfoi
    JOIN
        {{ ref('H3_dim_products') }} dp
    ON
        hfoi.product_id = dp.product_id
    GROUP BY dp.category
),
categoria_max_ventas AS (
    SELECT
        category,
        total_vendido
    FROM ventas_por_categoria
    ORDER BY total_vendido DESC
    LIMIT 1
)
SELECT * FROM categoria_max_ventas