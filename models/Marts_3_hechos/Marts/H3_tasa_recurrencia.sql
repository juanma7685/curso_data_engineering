WITH usuarios_ordenes AS (
    SELECT
        fo.user_id,
        COUNT(fo.order_id) AS total_ordenes
    FROM
        {{ ref('H3_facts_orders') }} fo
    GROUP BY
        fo.user_id
),
tasa_recurrencia AS (
    SELECT
        COUNT(CASE WHEN total_ordenes > 1 THEN 1 END) * 1.0 / COUNT(*) AS tasa_recurrencia
    FROM usuarios_ordenes
)
SELECT * FROM tasa_recurrencia