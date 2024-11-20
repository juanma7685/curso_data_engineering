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

promociones AS (
    SELECT
        p.promo_id,
        p.EUR_discount AS descuento_euros,
        p.status
    FROM {{ ref('stg_sql_server_dbo__promos') }} p
),

pedidos_facts AS (
    SELECT
        orders_facts.order_id,
        orders_facts.promo_id
    FROM {{ ref('stg_sql_server_dbo__orders') }} orders_facts
),

facturacion_producto AS (
    SELECT
        ip.product_id,
        p.nombre_producto,
        SUM(
            CASE
                WHEN promo.status = 'active' THEN
                    ip.quantity * (p.precio - promo.descuento_euros)
                ELSE
                    ip.quantity * p.precio
            END
        ) AS ingresos_producto,
        SUM(
            CASE
                WHEN promo.status = 'active' THEN
                    ip.quantity * promo.descuento_euros
                ELSE
                    0
            END
        ) AS descuento_total
    FROM items_pedido ip
    INNER JOIN productos p
        ON ip.product_id = p.product_id
    LEFT JOIN pedidos_facts pf
        ON ip.order_id = pf.order_id
    LEFT JOIN promociones promo
        ON pf.promo_id = promo.promo_id
    GROUP BY ip.product_id, p.nombre_producto
)

SELECT
    product_id,
    nombre_producto,
    ingresos_producto AS facturacion_total,
    descuento_total
FROM facturacion_producto
