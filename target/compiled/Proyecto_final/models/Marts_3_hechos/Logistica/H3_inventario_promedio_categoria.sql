WITH inventario_categoria AS (
    SELECT
        dp.category,
        AVG(dp.inventory) AS inventario_promedio
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_products dp
    GROUP BY
        dp.category
)
SELECT * FROM inventario_categoria