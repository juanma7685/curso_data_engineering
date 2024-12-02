{{ config(
    materialized='incremental',
    unique_key='product_id'
) }}

with 

source as (
    select * from {{ ref('stg_sql_server_dbo_snap_product') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),
renamed as (
    select
        product_id,
        precio,
        nombre_producto,
        category,
        inventory,
        p.llegada_id
    from source p
    join {{ ref('stg_sql_server_dbo__category') }} c 
        on p.category_id = c.category_id
)

select * from renamed