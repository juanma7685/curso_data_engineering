WITH items_pedido AS (
    SELECT
        oi.product_id,
        oi.quantity,
        oi.order_id
    FROM {{ ref('stg_sql_server_dbo__order_items') }} oi
),

productos AS (
    SELECT
        pr.product_id,
        pr.nombre_producto,
        pr.precio
    FROM {{ ref('stg_sql_server_dbo__products') }} pr
),

servicios_envio AS (
    SELECT
        oi.order_id,
        o.shipping_cost,
        SUM(oi.quantity) AS total_productos_pedido
    FROM {{ ref('stg_sql_server_dbo__order_items') }} oi
    INNER JOIN {{ ref('stg_sql_server_dbo__orders') }} o
        ON oi.order_id = o.order_id
    GROUP BY oi.order_id, o.shipping_cost
),

facturacion_producto AS (
    SELECT
        ip.product_id,
        p.nombre_producto,
        SUM(ip.quantity * p.precio) AS ingresos_producto,
        SUM(ip.quantity * (se.shipping_cost / se.total_productos_pedido)) AS costo_envio_proporcional
    FROM items_pedido ip
    INNER JOIN productos p
        ON ip.product_id = p.product_id
    LEFT JOIN servicios_envio se
        ON ip.order_id = se.order_id
    GROUP BY ip.product_id, p.nombre_producto
)

SELECT
    product_id,
    nombre_producto,
    ingresos_producto + costo_envio_proporcional AS facturacion_total
FROM facturacion_producto
