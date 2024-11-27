with 

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['order_id','product_id']) }} as order_items_id,
        order_id,
        product_id,
        quantity,
        _DLT_LOAD_ID as llegada_id

    from source

)

select * from renamed

