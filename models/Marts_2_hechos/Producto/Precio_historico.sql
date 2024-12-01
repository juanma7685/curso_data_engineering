WITH product_history AS (

SELECT
    ps.product_id,
    ps.nombre_producto,
    ps.precio as precio_original,
    dp.precio as precio_actual,
    ABS(precio_original - precio_actual) AS price_difference
FROM {{ ref("dim_products") }} dp
INNER JOIN {{ ref("products_snapshot") }} ps 
ON dp.product_id = ps.product_id
ORDER BY price_difference DESC

)

select * from product_history
