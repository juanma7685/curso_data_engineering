WITH my_cte AS (
    {{ dbt_utils.date_spine(
        datepart="hour",
        start_date="CAST('2019-01-01 00:00:00' AS TIMESTAMP)",
        end_date="CAST('2020-01-01 00:00:00' AS TIMESTAMP)"
    ) }}
)

SELECT 
    date_hour,
    EXTRACT(YEAR FROM date_hour) AS year,
    EXTRACT(MONTH FROM date_hour) AS month,
    EXTRACT(DAY FROM date_hour) AS day,
    EXTRACT(HOUR FROM date_hour) AS hour,
    EXTRACT(WEEK FROM date_hour) AS week,
    EXTRACT(DOW FROM date_hour) AS day_of_week, -- Día de la semana (0=Lunes, 6=Domingo)
    EXTRACT(DOY FROM date_hour) AS day_of_year -- Día del año (1-365 o 1-366 en años bisiestos)
FROM my_cte


