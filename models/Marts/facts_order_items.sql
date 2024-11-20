with 

source as (
    select * from {{ ref('stg_sql_server_dbo__order_items') }}
),

facts_order_items as (
    select
        order_items_id,
        order_id,
        product_id,
        quantity,
        _fivetran_deleted,
        _fivetran_synced
    from source
)

select * from facts_order_items
