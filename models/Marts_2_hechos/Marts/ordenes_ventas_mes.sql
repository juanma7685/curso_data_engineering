
WITH ordenes_ventas_agrupadas AS (
    SELECT
        df.month AS mes,
        df.year AS anyo,
        COUNT(DISTINCT fo.order_id) AS total_ordenes,
        SUM(do.order_total) AS valor_total_ventas
    FROM
        {{ ref('facts_orders') }} fo
    JOIN
        {{ ref('dim_orders') }} do
    ON
        fo.order_id = do.order_id
    JOIN
        {{ ref('dim_fecha') }} df
    ON
        do.created_at = df.date_day
    GROUP BY
        df.month, df.year
)
SELECT * FROM ordenes_ventas_agrupadas