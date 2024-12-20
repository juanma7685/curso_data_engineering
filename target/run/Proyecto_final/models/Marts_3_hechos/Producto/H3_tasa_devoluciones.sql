
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_tasa_devoluciones
  
   as (
    WITH devoluciones AS (
    SELECT
        fo.product_id,
        COUNT(dr.return_id) as devoluciones
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_returns dr
    JOIN
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_order_items fo
    ON
        dr.order_id = fo.order_id
    GROUP BY
        fo.product_id
),

total_producto_orders AS (
    SELECT
        dp.product_id,
        COUNT(DISTINCT fo.order_id) as total_ordenes
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_order_items fo
    JOIN
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_products dp
    ON
        fo.product_id = dp.product_id
    GROUP BY
        dp.product_id
),

producto_tasa_devoluciones AS (
    SELECT
        dp.product_id,
        dp.nombre_producto,
        dp.category,
        dp.precio,
        devoluciones / total_ordenes as tasa_devoluciones
    FROM devoluciones
    JOIN ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_products dp
    ON devoluciones.product_id = dp.product_id
    JOIN total_producto_orders tpo
    ON dp.product_id = tpo.product_id
    ORDER BY
        tasa_devoluciones DESC
)

SELECT * FROM producto_tasa_devoluciones
  );

