WITH product_prices AS (
    SELECT
        pr.product_id,
        pr.nombre_producto,
        CASE
            WHEN p.status = 'active' THEN
                pr.precio - p.EUR_discount
            ELSE
                pr.precio
        END AS precio_con_descuento
    FROM {{ ref('stg_sql_server_dbo__products') }} pr
    LEFT JOIN {{ ref('stg_sql_server_dbo__promos') }} p
        ON pr.product_id = p.promo_id
)

SELECT
    product_id,
    nombre_producto,
    precio_con_descuento
FROM product_prices
