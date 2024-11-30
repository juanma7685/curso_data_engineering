WITH tiempo_entrega AS (
    SELECT
        DATEDIFF(day, do.created_at, do.delivered_at) AS dias_entrega
    FROM
        {{ ref('H3_dim_orders') }} do
    WHERE
        do.delivered_at IS NOT NULL
),
promedio_entrega AS (
    SELECT
        AVG(dias_entrega) AS tiempo_promedio_entrega
    FROM tiempo_entrega
)
SELECT * FROM promedio_entrega
