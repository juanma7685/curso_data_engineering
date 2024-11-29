
with

    source as (select * from {{ source("google_sheets", "reviews") }}),

    renamed as (

        select
            review_id,
            {{ dbt_utils.generate_surrogate_key(["email"]) }} as user_id,
            {{ dbt_utils.generate_surrogate_key(["name","category"]) }} as product_id,
            rating::int as rating,
            comments,
            CAST(created_at AS DATE) as created_at,
            _DLT_LOAD_ID as llegada_id
        from source

    )

select *
from renamed