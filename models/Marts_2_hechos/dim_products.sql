{{ config(
    materialized='incremental',
    unique_key='product_id'
) }}

with 

source as (
    select * from {{ ref('stg_sql_server_dbo__products') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),

renamed as (
    select
        product_id,
        precio,
        nombre_producto,
        inventory,
        llegada_id
    from source
)

select * from renamed