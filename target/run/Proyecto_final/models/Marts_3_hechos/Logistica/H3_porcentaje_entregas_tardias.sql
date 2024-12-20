
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_porcentaje_entregas_tardias
  
   as (
    WITH entregas_tardias AS (
    SELECT
        COUNT(CASE WHEN do.delivered_at > do.estimated_delivery_at THEN 1 END) * 1.0 /
        COUNT(*) * 100 AS porcentaje_entregas_tardias
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_orders do
    WHERE
        do.delivered_at IS NOT NULL
)
SELECT * FROM entregas_tardias
  );

