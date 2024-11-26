with

    source as (select * from {{ source("google_sheets", "budget") }}),

    renamed as (

        select
            {{ dbt_utils.generate_surrogate_key(["product_id","quantity","month"])}} as budget_id,
            product_id,
            quantity::int as quantity,
            Month(month) as mes,
            Year(month) as anyo,
            _fivetran_synced

        from source

    )

select *
from renamed
