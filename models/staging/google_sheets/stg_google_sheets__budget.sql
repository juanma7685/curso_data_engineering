with

    source as (select * from {{ source("google_sheets", "budget") }}),

    renamed as (

        select
            product_id,
            quantity::int,
            month(month) as month,

        from source

    )

select *
from renamed
