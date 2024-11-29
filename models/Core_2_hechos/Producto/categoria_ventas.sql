
WITH ventas_por_categoria AS (
    SELECT
        dp.category,
        SUM(fo.quantity) AS total_vendido
    FROM
        {{ ref('facts_orders') }} fo
    JOIN
        {{ ref('dim_products') }} dp
    ON
        fo.product_id = dp.product_id
    GROUP BY dp.category
),
categoria_max_ventas AS (
    SELECT
        category,
        total_vendido
    FROM ventas_por_categoria
    ORDER BY total_vendido DESC
)
SELECT * FROM categoria_max_ventas