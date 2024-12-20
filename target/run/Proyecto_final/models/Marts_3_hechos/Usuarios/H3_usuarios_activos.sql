
  create or replace   view ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_usuarios_activos
  
   as (
    WITH usuarios_activos AS (
    SELECT
        df.month AS mes,
        df.year AS anyo,
        COUNT(DISTINCT fe.user_id) AS usuarios_activos
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_events fe
    JOIN
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_fecha df
    ON
        fe.created_at = df.date_day
    GROUP BY
        df.month, df.year
)
SELECT * FROM usuarios_activos
  );

