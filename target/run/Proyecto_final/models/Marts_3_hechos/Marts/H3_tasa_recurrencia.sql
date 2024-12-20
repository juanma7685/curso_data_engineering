
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_tasa_recurrencia
  
   as (
    WITH usuarios_ordenes AS (
    SELECT
        fo.user_id,
        COUNT(fo.order_id) AS total_ordenes
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_orders fo
    GROUP BY
        fo.user_id
),
tasa_recurrencia AS (
    SELECT
        COUNT(CASE WHEN total_ordenes > 1 THEN 1 END) * 1.0 / COUNT(*) AS tasa_recurrencia
    FROM usuarios_ordenes
)
SELECT * FROM tasa_recurrencia
  );

