
with 

source as (
    select * from {{ ref('fecha') }}
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