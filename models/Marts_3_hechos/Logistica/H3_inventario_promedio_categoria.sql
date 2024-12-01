WITH inventario_categoria AS (
    SELECT
        dp.category,
        AVG(dp.inventory) AS inventario_promedio
    FROM
        {{ ref('H3_dim_products') }} dp
    GROUP BY
        dp.category
)
SELECT * FROM inventario_categoria
