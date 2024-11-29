with 

source as (
    select * from {{ ref('stg_sql_server_dbo__products') }} p
    join {{ ref('stg_sql_server_dbo__category') }} c on p.category_id = c.category_id
),

renamed as (
    select
        product_id,
        precio,
        nombre_producto,
        category,
        inventory
    from source
)

select * from renamed