{{ config(
    materialized='incremental',
    unique_key='product_id'
) }}

with 

source as (
    select * from {{ ref('stg_sql_server_dbo__products') }}
    {% if is_incremental() %}
        where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})
    {% endif %}
),

renamed as (
    select
        product_id,
        precio,
        nombre_producto,
        inventory,
        _fivetran_deleted,
        _fivetran_synced
    from source
)

select * from renamed