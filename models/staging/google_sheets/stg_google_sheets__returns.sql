
with

    source as (select * from {{ source("google_sheets", "returns") }}),

    renamed as (

        select
            return_id,
            order_id,
            {{ dbt_utils.generate_surrogate_key(["email"]) }} as user_id,
            CAST(return_date as date) as return_date,
            _DLT_LOAD_ID as llegada_id
        from source

    )

select *
from renamed