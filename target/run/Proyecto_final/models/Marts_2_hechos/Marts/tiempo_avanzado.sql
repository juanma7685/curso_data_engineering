
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.tiempo_avanzado
  
   as (
    WITH ventas_por_tiempo AS (
    SELECT
        df.month AS mes,
        df.quarter AS trimestre,
        df.date_day,
        do.order_total
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_fecha df
    LEFT JOIN
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_orders do
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
    TO_CHAR(DATE_FROM_PARTS(1, mes, 1), 'Month') AS Meses,
    trimestre,
    ventas_totales_mes,
    ventas_totales_trimestre,
    COALESCE(ventas_totales_mes - LAG(ventas_totales_mes) OVER (ORDER BY mes), 0) AS variacion_mensual,
    COALESCE(ventas_totales_trimestre - LAG(ventas_totales_trimestre) OVER (ORDER BY trimestre), 0) AS variacion_trimestral
FROM
    ventas_agregadas
ORDER BY
    mes
  );

