
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.producto_ventas
  
   as (
    WITH facturacion_por_producto AS (
    SELECT
        dp.product_id,
        SUM(dp.precio * fo.quantity) AS total_facturado,
        SUM(fo.quantity) AS total_vendido
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.facts_orders fo
    JOIN
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_products dp
    ON
        fo.product_id = dp.product_id
    GROUP BY
        dp.product_id
),
producto_max_facturacion AS (
    SELECT
        dp.product_id,
        dp.nombre_producto,
        dp.category,
        dp.precio,
        total_facturado,
        total_vendido
        FROM facturacion_por_producto
        JOIN ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_products dp
        ON facturacion_por_producto.product_id = dp.product_id
    ORDER BY
        total_facturado DESC
)
SELECT * FROM producto_max_facturacion
  );

