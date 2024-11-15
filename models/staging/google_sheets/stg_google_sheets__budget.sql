with

    source as (select * from {{ source("google_sheets", "budget") }}),

    renamed as (

        select
            product_id,
            quantity::int as quantity,
            MONTH(month) as Datemonth,
            TO_CHAR(month, 'Month') AS NombreMes

        from source

    )

select *
from renamed
