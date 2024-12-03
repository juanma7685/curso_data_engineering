{{
  config(
    materialized='incremental',
    unique_key='budget_id'
  )
}}

with source as (
    select * from {{ source("google_sheets", "budget") }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(["name", "category", "quantity", "month"]) }} as budget_id,
        {{ dbt_utils.generate_surrogate_key(["name", "category"]) }} as product_id,
        quantity::int as quantity,
        Month(month) as mes,
        Year(month) as anyo,
        _DLT_LOAD_ID as llegada_id
    from source
),

deduplicated as (
    select *,
        row_number() over (partition by budget_id order by llegada_id desc) as row_num
    from renamed
)

select *
from deduplicated
where row_num = 1

{% if is_incremental() %}
and llegada_id > (select max(llegada_id) from {{ this }})
{% endif %}
