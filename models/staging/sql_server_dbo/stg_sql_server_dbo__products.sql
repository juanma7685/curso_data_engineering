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
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
