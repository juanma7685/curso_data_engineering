WITH items_pedido AS (
    SELECT
        oi.order_id,
        oi.quantity,
        oi.product_id
    FROM {{ ref('stg_sql_server_dbo__order_items') }} oi
),

productos AS (
    SELECT
        pr.product_id,
        pr.precio
    FROM {{ ref('stg_sql_server_dbo__products') }} pr
),

pedidos AS (
    SELECT
        o.order_id,
        o.created_at
    FROM {{ ref('stg_sql_server_dbo__orders') }} o
),

facturacion_dia AS (
    SELECT
        f.day_name AS day_name,
        SUM(ip.quantity * pr.precio) AS ingresos_totales
    FROM items_pedido ip
    INNER JOIN productos pr
        ON ip.product_id = pr.product_id
    INNER JOIN pedidos p
        ON ip.order_id = p.order_id
    INNER JOIN {{ ref('fecha') }} f
        ON p.created_at = f.date_day
    GROUP BY f.day_name
)

SELECT
    day_name,
    ingresos_totales AS total_per_day
FROM facturacion_dia
