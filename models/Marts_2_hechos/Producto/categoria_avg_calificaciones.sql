WITH calificaciones_categoria AS (
    SELECT
        dp.category,
        AVG(dr.rating) AS promedio_calificacion
    FROM
        {{ ref('dim_reviews') }} dr
    JOIN
        {{ ref('dim_products') }} dp
    ON
        dr.product_id = dp.product_id
    GROUP BY dp.category
)
SELECT * FROM calificaciones_categoria
