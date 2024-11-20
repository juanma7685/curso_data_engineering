with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        order_id,
        shipping_cost,
        CAST(created_at AS DATE) as created_at,
        CAST(estimated_delivery_at AS DATE) as estimated_delivery_at,
        order_cost,
        order_total,
        CAST(delivered_at AS DATE) as delivered_at,
        tracking_id,
        _fivetran_deleted,
        _fivetran_synced
    from source 
)

select * from renamed
