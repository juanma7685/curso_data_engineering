{{
  config(
    materialized='incremental',
    unique_key='category_id'
  )
}}

with 

source as (
    select * 
    from {{ source('sql_server_dbo', 'products') }}
),

renamed as (
    select DISTINCT
        {{ dbt_utils.generate_surrogate_key(["category"]) }} as category_id,
        category,
        _DLT_LOAD_ID as llegada_id
    from source
),

deduplicated as (
    select *, 
           row_number() over (partition by category_id order by llegada_id desc) as row_num
    from renamed
)

select *
from deduplicated
where row_num = 1

{% if is_incremental() %}
and llegada_id > (select max(llegada_id) from {{ this }})
{% endif %}
