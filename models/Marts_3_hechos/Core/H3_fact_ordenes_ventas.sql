WITH ordenes_ventas_agrupadas AS (
    SELECT
        df.date_day AS dia,
        df.month AS mes,
        df.year AS anyo,
        COUNT(DISTINCT hfo.order_id) AS total_ordenes,
        SUM(hdo.order_total) AS valor_total_ventas
    FROM
        {{ ref('H3_facts_orders') }} hfo
    JOIN
        {{ ref('H3_dim_orders') }} hdo
    ON
        hfo.order_id = hdo.order_id
    JOIN
        {{ ref('H3_dim_fecha') }} df
    ON
        hdo.created_at = df.date_day
    GROUP BY
        df.date_day, df.month, df.year
)
SELECT * FROM ordenes_ventas_agrupadas
