WITH calificacion_promedio AS (
    SELECT
        dr.product_id,
        AVG(dr.rating) AS calificacion_promedio,
        COUNT(dr.rating) AS numero_calificaciones
    FROM
        {{ ref('H3_dim_reviews') }} dr
    GROUP BY
        dr.product_id
),
producto_calificacion_promedio AS (
    SELECT
        dp.product_id,
        dp.nombre_producto,
        dp.category,
        cp.calificacion_promedio,
        cp.numero_calificaciones
    FROM calificacion_promedio cp
    JOIN {{ ref('H3_dim_products') }} dp
    ON cp.product_id = dp.product_id
    ORDER BY 
        cp.calificacion_promedio DESC
)

select * from producto_calificacion_promedio