with

    source as (select * from {{ source("google_sheets", "budget") }}),

    renamed as (

        select
            {{ dbt_utils.generate_surrogate_key(["name","category","quantity","month"])}} as budget_id,
            {{ dbt_utils.generate_surrogate_key(["name","category"]) }} as product_id,
            quantity::int as quantity,
            Month(month) as mes,
            Year(month) as anyo,
            _DLT_LOAD_ID as llegada_id
        from source

    )

{% if is_incremental() %}

    select * from renamed
    where llegada_id > (select max(llegada_id) from {{ this }})

{% else %}

    select * from renamed

{% endif %}
