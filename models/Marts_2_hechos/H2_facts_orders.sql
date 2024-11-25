with 

source_orders as (
    select * from {{ ref('stg_sql_server_dbo__orders') }}
),

source_order_items as (
    select * from {{ ref('stg_sql_server_dbo__order_items') }}
),

facts_orders as (
    select
        o.order_id,
        o.address_id,
        o.user_id,
        oi.order_items_id,
        oi.product_id,
        oi.quantity,
        oi._fivetran_deleted,
        oi._fivetran_synced
    from source_orders o
    join source_order_items oi on o.order_id = oi.order_id
)

select * from facts_orders
