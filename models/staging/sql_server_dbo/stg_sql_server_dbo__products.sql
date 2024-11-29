with 

source as (
    select * 
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
    select
        {{ dbt_utils.generate_surrogate_key(["null", "null"]) }} as product_id,
        0 as precio,
        'no products' as nombre_producto,
        'no products' as category,
        0 as inventory,
        null as llegada_id
)

select * from renamed

union all

select * from no_products
