WITH usuarios_activos AS (
    SELECT
        df.month AS mes,
        df.year AS anyo,
        COUNT(DISTINCT fe.user_id) AS usuarios_activos
    FROM
        {{ ref('H3_facts_events') }} fe
    JOIN
        {{ ref('H3_dim_fecha') }} df
    ON
        fe.created_at = df.date_day
    GROUP BY
        df.month, df.year
)
SELECT * FROM usuarios_activos