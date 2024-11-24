
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
        anyo
    from source
)

select * from renamed