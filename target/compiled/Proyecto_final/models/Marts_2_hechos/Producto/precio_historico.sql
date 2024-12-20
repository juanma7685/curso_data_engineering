WITH product_history AS (

SELECT
    ps.product_id,
    ps.nombre_producto,
    ps.precio as precio_original,
    dp.precio as precio_actual,
    ABS(precio_original - precio_actual) AS price_difference
FROM ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_products dp
INNER JOIN ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.product_snap ps 
ON dp.product_id = ps.product_id
WHERE price_difference > 0
ORDER BY price_difference DESC

)

select * from product_history