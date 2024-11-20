with 

source as (
    select * from {{ ref('stg_sql_server_dbo__orders') }}
),

facts_orders as (
    select
        order_id,
        address_id,
        user_id,
        shipping_service_id,
        promo_id,
        status_id
    from source
)

select * from facts_orders
