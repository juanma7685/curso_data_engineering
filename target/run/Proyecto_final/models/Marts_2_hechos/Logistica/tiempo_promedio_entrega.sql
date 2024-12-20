
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.tiempo_promedio_entrega
  
   as (
    WITH tiempo_entrega AS (
    SELECT
        DATEDIFF(day, do.created_at, do.delivered_at) AS dias_entrega
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_orders do
    WHERE
        do.delivered_at IS NOT NULL
),
promedio_entrega AS (
    SELECT
        AVG(dias_entrega) AS tiempo_promedio_entrega
    FROM tiempo_entrega
)
SELECT * FROM promedio_entrega
  );

