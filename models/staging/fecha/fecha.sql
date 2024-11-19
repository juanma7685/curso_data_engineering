WITH my_cte AS (
    {{ dbt_utils.date_spine(
        datepart="hour",
        start_date="CAST('2019-01-01 00:00:00' AS TIMESTAMP)",
        end_date="CAST('2020-01-01 00:00:00' AS TIMESTAMP)"
    ) }}
)

SELECT 
    date_hour,
    CAST(date_hour AS DATE) AS date, -- Nueva columna para la fecha sin la hora
    {{ dbt_utils.generate_surrogate_key(['date_hour']) }} AS id_fecha_hora, -- Clave subrrogada con fecha y hora
    {{ dbt_utils.generate_surrogate_key(['CAST(date_hour AS DATE)']) }} AS id_fecha, -- Clave subrrogada sin la hora
    EXTRACT(YEAR FROM date_hour) AS year,
    EXTRACT(MONTH FROM date_hour) AS month,
    EXTRACT(DAY FROM date_hour) AS day,
    EXTRACT(HOUR FROM date_hour) AS hour,
    EXTRACT(WEEK FROM date_hour) AS week,
    EXTRACT(DOW FROM date_hour) AS day_of_week, -- Día de la semana (0=Lunes, 6=Domingo)
    EXTRACT(DOY FROM date_hour) AS day_of_year, -- Día del año (1-365 o 1-366 en años bisiestos)
    EXTRACT(QUARTER FROM date_hour) AS quarter,
    CASE 
        WHEN EXTRACT(DOW FROM date_hour) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type
FROM my_cte


