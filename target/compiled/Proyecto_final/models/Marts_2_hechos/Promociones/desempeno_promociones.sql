WITH desempeno_promociones AS (
    WITH descuentos_unicos AS (
        SELECT
            foi.order_id,
            do.nombre_promocion,
            do.EUR_discount
        FROM
            ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.facts_orders foi
        JOIN
            ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_orders do
        ON
            foi.order_id = do.order_id
        GROUP BY
            foi.order_id, do.nombre_promocion, do.EUR_discount
    )

    SELECT
        du.nombre_promocion,
        COUNT(DISTINCT du.order_id) AS numero_ordenes_afectadas,
        SUM(du.EUR_discount) AS total_descuentos,
        AVG(do.order_total) AS gasto_promedio_por_orden
    FROM
        descuentos_unicos du
    JOIN
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_orders do
    ON
        du.order_id = do.order_id
    GROUP BY
        du.nombre_promocion
)

SELECT * FROM desempeno_promociones