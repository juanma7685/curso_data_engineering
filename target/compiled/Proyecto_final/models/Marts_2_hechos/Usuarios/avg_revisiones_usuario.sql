WITH calificacion_promedio AS (
    SELECT
        dr.user_id,
        AVG(dr.rating) AS calificacion_promedio
    FROM
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_reviews dr
    GROUP BY
        dr.user_id
),
usuario_calificacion_promedio AS (
    SELECT
        du.user_id,
        du.first_name,
        du.last_name,
        du.email,
        cp.calificacion_promedio
    FROM calificacion_promedio cp
    JOIN ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_users du
    ON cp.user_id = du.user_id
)

select * from usuario_calificacion_promedio