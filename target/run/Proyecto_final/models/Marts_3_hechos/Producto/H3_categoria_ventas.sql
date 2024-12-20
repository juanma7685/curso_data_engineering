
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_categoria_ventas
  
   as (
    WITH facturacion_por_categoria AS (
    SELECT
        dp.category,
        SUM(dp.precio * fo.quantity) AS total_facturado,
        SUM(fo.quantity) AS total_vendido
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_order_items fo
    JOIN
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_products dp
    ON
        fo.product_id = dp.product_id
    GROUP BY dp.category
),
categoria_max_facturacion AS (
    SELECT
        category,
        total_facturado,
        total_vendido
    FROM facturacion_por_categoria
    ORDER BY total_facturado DESC
)
SELECT * FROM categoria_max_facturacion
  );

