WITH entregas_tardias AS (
    SELECT
        COUNT(CASE WHEN do.delivered_at > do.estimated_delivery_at THEN 1 END) * 1.0 /
        COUNT(*) AS porcentaje_entregas_tardias
    FROM
        {{ ref('dim_orders') }} do
    WHERE
        do.delivered_at IS NOT NULL
)
SELECT * FROM entregas_tardias
