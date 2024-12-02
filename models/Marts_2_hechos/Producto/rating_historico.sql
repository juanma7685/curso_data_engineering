WITH reviews_snapshot AS (
    SELECT
        rs.review_id,
        rs.product_id,
        rs.rating AS rating_snapshot,
        rs.comments AS comments_snapshot
    FROM {{ ref("review_snap") }} rs
),

calificacion_promedio_actual AS (
    SELECT
        dr.product_id,
        AVG(dr.rating) AS calificacion_promedio_actual,
        COUNT(dr.rating) AS numero_calificaciones_actuales
    FROM
        {{ ref('dim_reviews') }} dr
    GROUP BY
        dr.product_id
),

calificacion_promedio_historica AS (
    SELECT
        rs.product_id,
        AVG(rs.rating_snapshot) AS calificacion_promedio_historica,
        COUNT(rs.rating_snapshot) AS numero_calificaciones_historicas
    FROM
        reviews_snapshot rs
    GROUP BY
        rs.product_id
),

comparacion_reviews AS (
    SELECT
        ca.product_id,
        dp.nombre_producto,
        dp.category,
        ca.calificacion_promedio_actual,
        ca.numero_calificaciones_actuales,
        ch.calificacion_promedio_historica,
        ch.numero_calificaciones_historicas,
        ABS(ca.calificacion_promedio_actual - ch.calificacion_promedio_historica) AS diferencia_calificacion_promedio,
        ca.numero_calificaciones_actuales - ch.numero_calificaciones_historicas AS diferencia_numero_calificaciones
    FROM
        calificacion_promedio_actual ca
    LEFT JOIN
        calificacion_promedio_historica ch
    ON
        ca.product_id = ch.product_id
    JOIN
        {{ ref('dim_products') }} dp
    ON
        ca.product_id = dp.product_id
)

SELECT
    *
FROM
    comparacion_reviews
WHERE diferencia_calificacion_promedio > 0
ORDER BY
    diferencia_calificacion_promedio DESC
