WITH product_history AS (

SELECT
    ps.product_id,
    ps.nombre_producto,
    ps.precio as precio_original,
    dp.precio as precio_actual,
    ABS(precio_original - precio_actual) AS price_difference
FROM {{ ref("dim_products") }} dp
INNER JOIN {{ ref("product_snap") }} ps 
ON dp.product_id = ps.product_id
WHERE price_difference > 0
ORDER BY price_difference DESC

)

select * from product_history
