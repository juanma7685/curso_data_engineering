WITH ordenes_ventas_agrupadas AS (
    SELECT
        TO_CHAR(DATE_FROM_PARTS(df.year, df.month, 1), 'Month') AS mes,
        df.year AS anyo,
        COUNT(fo.order_id) AS total_ordenes,
        SUM(do.order_total) AS valor_total_ventas
    FROM
        {{ ref('H3_facts_orders') }} fo
    JOIN
        {{ ref('H3_dim_orders') }} do
    ON
        fo.order_id = do.order_id
    JOIN
        {{ ref('H3_dim_fecha') }} df
    ON
        do.created_at = df.date_day
    GROUP BY
        df.month, df.year
    ORDER BY
        total_ordenes DESC
)
SELECT * FROM ordenes_ventas_agrupadas