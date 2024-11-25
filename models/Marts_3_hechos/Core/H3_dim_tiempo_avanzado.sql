WITH ventas_por_tiempo AS (
    SELECT
        df.month AS mes,
        df.quarter AS trimestre,
        df.date_day,
        do.order_total
    FROM
        {{ ref('H3_dim_fecha') }} df
    LEFT JOIN
        {{ ref('H3_dim_orders') }} do
    ON
        df.date_day = do.created_at
),
ventas_agregadas AS (
    SELECT
        mes,
        trimestre,
        COALESCE(SUM(order_total),0) AS ventas_totales_mes,
        COALESCE(SUM(SUM(order_total)) OVER (PARTITION BY trimestre),0) AS ventas_totales_trimestre
    FROM
        ventas_por_tiempo
    GROUP BY
        mes, trimestre
)

SELECT
    mes,
    trimestre,
    ventas_totales_mes,
    ventas_totales_trimestre,
    COALESCE(ventas_totales_mes - LAG(ventas_totales_mes) OVER (ORDER BY mes), 0) AS variacion_mensual,
    COALESCE(ventas_totales_trimestre - LAG(ventas_totales_trimestre) OVER (ORDER BY trimestre), 0) AS variacion_trimestral
FROM
    ventas_agregadas
ORDER BY
    mes
