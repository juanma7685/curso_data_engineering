
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_entregas_a_tiempo
  
   as (
    WITH entregas_tiempo AS (
    SELECT
        COUNT(CASE WHEN do.delivered_at <= do.estimated_delivery_at THEN 1 END) * 1.0 / COUNT(*) AS tasa_entregas_tiempo
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_orders do
)
SELECT * FROM entregas_tiempo
  );

