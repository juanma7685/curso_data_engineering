with dim_eficiencia_envios as (
    SELECT
        do.shipping_service AS nombre_servicio_envio,
        COUNT(fo.order_id) AS total_envios,
        SUM(do.shipping_cost) AS costo_envio_total,
        AVG(do.shipping_cost) AS costo_envio_promedio,
        AVG(DATEDIFF(DAY, do.created_at, do.delivered_at)) AS promedio_tiempo_entrega_dias
    FROM
        {{ ref('facts_orders') }} fo
    LEFT JOIN
        {{ ref('dim_orders') }} do
    ON
        fo.order_id = do.order_id
    GROUP BY
        do.shipping_service
)
select * from dim_eficiencia_envios
