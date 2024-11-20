WITH my_cte AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="CAST('2019-01-01 00:00:00' AS DATE)",
        end_date="CAST('2026-01-01 00:00:00' AS DATE)"
    ) }}
),
unioned_dates AS (
    SELECT 
        date_day,
        EXTRACT(YEAR FROM date_day) AS year,
        EXTRACT(MONTH FROM date_day) AS month,
        EXTRACT(DAY FROM date_day) AS day,
        EXTRACT(WEEK FROM date_day) AS week,
        EXTRACT(DOW FROM date_day) AS day_of_week, -- Día de la semana (0=Lunes, 6=Domingo)
        EXTRACT(DOY FROM date_day) AS day_of_year, -- Día del año (1-365 o 1-366 en años bisiestos)
        EXTRACT(QUARTER FROM date_day) AS quarter,
        CASE 
            WHEN EXTRACT(DOW FROM date_day) IN (0, 6) THEN 'Weekend'
            ELSE 'Weekday'
        END AS day_type
    FROM my_cte

    UNION ALL

    SELECT 
        CAST('1970-01-01' AS DATE) AS date, -- Fecha sin hora
        1970 AS year, -- Año por defecto
        1 AS month, -- Mes por defecto
        1 AS day, -- Día por defecto
        1 AS week, -- Primera semana del año
        4 AS day_of_week, -- Día de la semana (1=Jueves para 1970-01-01)
        1 AS day_of_year, -- Primer día del año
        1 AS quarter, -- Primer trimestre del año
        'Unknown' AS day_type -- Tipo de día predeterminado
)

SELECT *
FROM unioned_dates
