{{
  config(
    materialized='incremental',
    unique_key='product_id'
  )
}}

with 

source as (
    select distinct *
    from {{ source('sql_server_dbo', 'products') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(["name", "category"]) }} as product_id,
        price::decimal(10, 2) as precio,
        name as nombre_producto,
        {{ dbt_utils.generate_surrogate_key(["category"]) }} as category_id,
        inventory,
        _DLT_LOAD_ID as llegada_id
    from source
),

no_products as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(["null", "null"]) }} as product_id,
        0 as precio,
        'no products' as nombre_producto,
        {{ dbt_utils.generate_surrogate_key(["'no products'"]) }} as category_id,
        0 as inventory,
        '0' as llegada_id
),

deduplicated as (
    select *, 
           row_number() over (partition by product_id order by llegada_id desc) as row_num
    from (
        select * from renamed
        union all
        select * from no_products
    )
)

select *
from deduplicated
where row_num = 1

{% if is_incremental() %}
and llegada_id > (select max(llegada_id) from {{ this }})
{% endif %}
