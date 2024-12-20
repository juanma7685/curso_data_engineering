WITH calificaciones_categoria AS (
    SELECT
        dp.category,
        AVG(dr.rating) AS promedio_calificacion,
        COUNT(dr.rating) AS numero_calificaciones
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_reviews dr
    JOIN
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_products dp
    ON
        dr.product_id = dp.product_id
    GROUP BY dp.category
)
SELECT * FROM calificaciones_categoria