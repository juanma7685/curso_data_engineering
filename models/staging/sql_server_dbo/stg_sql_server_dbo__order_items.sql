{{
  config(
    materialized='incremental',
    unique_key='order_items_id'
  )
}}

with 

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(["order_id","name","category"]) }} as order_items_id,
        order_id,
        {{ dbt_utils.generate_surrogate_key(["name","category"]) }} as product_id,
        quantity,
        _DLT_LOAD_ID as llegada_id

    from source

)

select * from renamed

{% if is_incremental() %}
where llegada_id > (select max(llegada_id) from {{ this }})
{% endif %}

