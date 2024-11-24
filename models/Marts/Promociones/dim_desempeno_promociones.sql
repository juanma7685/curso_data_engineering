SELECT
    do.name AS nombre_promocion,
    COUNT(fo.order_id) AS numero_ordenes_afectadas,
    COALESCE(SUM(do.EUR_discount), 0) AS total_descuentos,
    COALESCE(AVG(do.order_total), 0) AS gasto_promedio_por_orden
FROM
    {{ ref('dim_orders') }} do
LEFT JOIN
    {{ ref('facts_orders') }} fo
ON
    do.order_id = fo.order_id
GROUP BY
    do.name
