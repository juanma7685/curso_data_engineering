WITH entregas_tardias AS (
    SELECT
        COUNT(CASE WHEN do.delivered_at > do.estimated_delivery_at THEN 1 END) * 1.0 /
        COUNT(*) * 100 AS porcentaje_entregas_tardias
    FROM
        {{ ref('H3_dim_orders') }} do
    WHERE
        do.delivered_at IS NOT NULL
)
SELECT * FROM entregas_tardias
