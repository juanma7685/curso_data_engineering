SELECT
    ds.shipping_service_id,
    ds.shipping_service AS nombre_servicio_envio,
    COUNT(fo.order_id) AS total_envios,
    SUM(do.shipping_cost) AS costo_envio_total,
    AVG(do.shipping_cost) AS costo_envio_promedio,
    AVG(DATEDIFF(DAY, do.created_at, do.delivered_at)) AS promedio_tiempo_entrega_dias
FROM
    {{ ref('dim_shipping_service') }} ds
LEFT JOIN
    {{ ref('facts_orders') }} fo
ON
    ds.shipping_service_id = fo.shipping_service_id
LEFT JOIN
    {{ ref('dim_orders') }} do
ON
    fo.order_id = do.order_id
GROUP BY
    ds.shipping_service_id, ds.shipping_service
