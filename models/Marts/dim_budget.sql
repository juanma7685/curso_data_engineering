
with 

source as (
    select * from {{ ref('stg_google_sheets__budget') }}
),

renamed as (
    select
        budget_id,
        product_id,
        quantity,
        mes,
        nombre_mes
    from source
)

select * from renamed