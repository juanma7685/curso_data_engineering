WITH costo_envio AS (
    SELECT
        AVG(do.shipping_cost) AS costo_promedio_envio
    FROM
        {{ ref('dim_orders') }} do
)
SELECT * FROM costo_envio
