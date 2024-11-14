with

    source as (select * from {{ source("google_sheets", "budget") }}),

    renamed as (

        select
            _row::int,
            product_id,
            quantity::int,
            month(month) as month,
            _fivetran_synced as date_load

        from source

    )

select *
from renamed
