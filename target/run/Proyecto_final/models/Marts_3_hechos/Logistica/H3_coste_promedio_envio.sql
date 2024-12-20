
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_coste_promedio_envio
  
   as (
    WITH costo_envio AS (
    SELECT
        AVG(do.shipping_cost) AS costo_promedio_envio
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_orders do
)
SELECT * FROM costo_envio
  );

