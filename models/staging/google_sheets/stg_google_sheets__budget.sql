with

    source as (select * from {{ source("google_sheets", "budget") }}),

    renamed as (

        select
            _ROW as Budget_id,
            product_id,
            quantity::int as quantity,
            month as fecha,
            to_char(month, 'Month') as nombremes

        from source

    )

select *
from renamed
