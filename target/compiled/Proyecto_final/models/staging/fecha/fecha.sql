WITH my_cte AS (
    





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
     + 
    
    p11.generated_number * power(2, 11)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
     cross join 
    
    p as p11
    
    

    )

    select *
    from unioned
    where generated_number <= 2557
    order by generated_number



),

all_periods as (

    select (
        

    dateadd(
        day,
        row_number() over (order by 1) - 1,
        CAST('2019-01-01 00:00:00' AS DATE)
        )


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= CAST('2026-01-01 00:00:00' AS DATE)

)

select * from filtered


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
        END AS day_type,
        CASE 
            WHEN EXTRACT(DOW FROM date_day) = 0 THEN 'Monday'
            WHEN EXTRACT(DOW FROM date_day) = 1 THEN 'Tuesday'
            WHEN EXTRACT(DOW FROM date_day) = 2 THEN 'Wednesday'
            WHEN EXTRACT(DOW FROM date_day) = 3 THEN 'Thursday'
            WHEN EXTRACT(DOW FROM date_day) = 4 THEN 'Friday'
            WHEN EXTRACT(DOW FROM date_day) = 5 THEN 'Saturday'
            WHEN EXTRACT(DOW FROM date_day) = 6 THEN 'Sunday'
        END AS day_name -- Nombre del día de la semana
    FROM my_cte

    UNION ALL

    SELECT 
        CAST('1970-01-01' AS DATE) AS date_day, -- Fecha sin hora
        1970 AS year, -- Año por defecto
        1 AS month, -- Mes por defecto
        1 AS day, -- Día por defecto
        1 AS week, -- Primera semana del año
        4 AS day_of_week, -- Día de la semana (1=Jueves para 1970-01-01)
        1 AS day_of_year, -- Primer día del año
        1 AS quarter, -- Primer trimestre del año
        'Unknown' AS day_type, -- Tipo de día predeterminado
        'Thursday' AS day_name -- Nombre del día para la fecha 1970-01-01
)

SELECT *
FROM unioned_dates