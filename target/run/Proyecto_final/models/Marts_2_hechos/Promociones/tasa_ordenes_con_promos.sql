
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.tasa_ordenes_con_promos
  
   as (
    WITH ordenes_promociones AS (
    SELECT
        COUNT(CASE WHEN do.EUR_discount > 0 THEN 1 END) * 1.0 / COUNT(*) AS tasa_ordenes_promocion
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_orders do
)
SELECT * FROM ordenes_promociones
  );

