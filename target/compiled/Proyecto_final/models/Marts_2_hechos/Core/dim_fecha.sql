with 

source as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.fecha
),

renamed as (
    select
        date_day,
        year,
        month,
        day,
        week,
        day_of_week,
        day_of_year,
        quarter,
        day_type,
        day_name
    from source
)

select * from renamed