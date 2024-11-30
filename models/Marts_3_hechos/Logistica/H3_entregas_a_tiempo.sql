WITH entregas_tiempo AS (
    SELECT
        COUNT(CASE WHEN do.delivered_at <= do.estimated_delivery_at THEN 1 END) * 1.0 / COUNT(*) AS tasa_entregas_tiempo
    FROM
        {{ ref('H3_dim_orders') }} do
)
SELECT * FROM entregas_tiempo