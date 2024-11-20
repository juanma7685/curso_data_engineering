with 

source as (
    select * from {{ ref('stg_sql_server_dbo__orders') }}
),

dim_orders as (
    select
        order_id,
        shipping_cost,
        created_at,
        estimated_delivery_at,
        order_cost,
        order_total,
        delivered_at,
        tracking_id,
        _fivetran_deleted,
        _fivetran_synced
    from source
)

select * from dim_orders
