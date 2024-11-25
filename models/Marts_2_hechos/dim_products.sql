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
)

select * from renamed