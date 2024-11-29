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
)

select * from renamed

{% if is_incremental() %}
where llegada_id > (select max(llegada_id) from {{ this }})
{% endif %}
