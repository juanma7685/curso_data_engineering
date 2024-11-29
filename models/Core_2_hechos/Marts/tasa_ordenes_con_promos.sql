WITH ordenes_promociones AS (
    SELECT
        COUNT(CASE WHEN do.EUR_discount > 0 THEN 1 END) * 1.0 / COUNT(*) AS tasa_ordenes_promocion
    FROM
        {{ ref('dim_orders') }} do
)
SELECT * FROM ordenes_promociones
