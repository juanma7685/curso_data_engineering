
with 

source as (
    select * from {{ ref('stg_sql_server_dbo__products') }}
),

renamed as (
    select
        product_id,
        precio,
        nombre_producto,
        inventory
    from source
    where _fivetran_deleted = false
)

select * from renamed