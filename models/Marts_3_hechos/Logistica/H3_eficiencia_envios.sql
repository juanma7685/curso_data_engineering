WITH shipping_efficiency AS (
    WITH unique_shipping_costs AS (
        SELECT
            foi.order_id,
            do.shipping_service,
            do.shipping_cost
        FROM
            {{ ref('H3_facts_orders') }} foi
        JOIN
            {{ ref('H3_dim_orders') }} do
        ON
            foi.order_id = do.order_id
        GROUP BY
            foi.order_id, do.shipping_service, do.shipping_cost
    )
    SELECT
        usc.shipping_service,
        COUNT(DISTINCT usc.order_id) AS total_envios,
        SUM(usc.shipping_cost) AS costo_envio_total,
        AVG(usc.shipping_cost) AS costo_envio_promedio,
        AVG(DATEDIFF(DAY, do.created_at, do.delivered_at)) AS promedio_tiempo_entrega
    FROM
        unique_shipping_costs usc
    JOIN
        {{ ref('H3_dim_orders') }} do
    ON
        usc.order_id = do.order_id
    GROUP BY
        usc.shipping_service
    ORDER BY costo_envio_total DESC
)
SELECT * FROM shipping_efficiency