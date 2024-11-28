with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed as (

    select
        product_id,
        price::DECIMAL(10,2) as precio,
        name as nombre_producto,
        inventory,
        _DLT_LOAD_ID as llegada_id

    from source

)

select * from renamed
