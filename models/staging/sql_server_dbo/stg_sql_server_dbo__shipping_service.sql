{{ config(
    materialized='incremental',
    unique_key='shipping_service_id'
) }}

with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(["shipping_service"]) }} as shipping_service_id,
        shipping_service,
        _DLT_LOAD_ID as llegada_id
    from source
)

select distinct * from renamed

{% if is_incremental() %}

where llegada_id > (select max(llegada_id) from {{ this }})

{% endif %}
