{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

with 

source_order_items as (
    select * from {{ ref('stg_sql_server_dbo__order_items') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),

facts_order_items as (
    select
        oi.order_items_id,
        oi.product_id,
        oi.quantity,
        oi.llegada_id
    from source_order_items oi 
)

select * from facts_orders
