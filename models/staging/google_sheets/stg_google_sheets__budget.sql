with

    source as (select * from {{ source("google_sheets", "budget") }}),

    renamed as (

        select
            {{ dbt_utils.generate_surrogate_key(["product_id","quantity","month"])}} as budget_id,
            product_id,
            quantity::int as quantity,
            Month(month) as mes,
            to_char(month, 'Month') as nombre_mes

        from source

    )

select *
from renamed
