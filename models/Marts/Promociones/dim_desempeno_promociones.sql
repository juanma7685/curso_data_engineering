SELECT
    dp.promo_id,
    dp.name AS nombre_promocion,
    COUNT(fo.order_id) AS numero_ordenes_afectadas,
    SUM(dp.EUR_discount) AS total_descuentos,
    AVG(do.order_total) AS gasto_promedio_por_orden
FROM
    {{ ref('dim_promos') }} dp
LEFT JOIN
    {{ ref('facts_orders') }} fo
ON
    dp.promo_id = fo.promo_id
LEFT JOIN
    {{ ref('dim_orders') }} do
ON
    fo.order_id = do.order_id
GROUP BY
    dp.promo_id, dp.name
