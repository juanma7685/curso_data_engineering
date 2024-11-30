
WITH calificacion_promedio AS (
    SELECT
        dr.product_id,
        AVG(dr.rating) AS calificacion_promedio
    FROM
        {{ ref('dim_reviews') }} dr
    GROUP BY
        dr.product_id
),
producto_calificacion_promedio AS (
    SELECT
        dp.product_id,
        dp.nombre_producto,
        dp.category,
        cp.calificacion_promedio
    FROM calificacion_promedio cp
    JOIN {{ ref('dim_products') }} dp
    ON cp.product_id = dp.product_id
)

select * from producto_calificacion_promedio