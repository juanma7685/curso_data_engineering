with dim_desempeno_promociones as (
    SELECT
        do.nombre_promocion AS nombre_promocion,
        COUNT(fo.order_id) AS numero_ordenes_afectadas,
        COALESCE(SUM(do.EUR_discount), 0) AS total_descuentos,
        COALESCE(AVG(do.order_total), 0) AS gasto_promedio_por_orden
    FROM
        {{ ref('H3_dim_orders') }} do
    LEFT JOIN
        {{ ref('H3_facts_orders') }} fo
    ON
        do.order_id = fo.order_id
    GROUP BY
        do.nombre_promocion
)

SELECT * FROM dim_desempeno_promociones
