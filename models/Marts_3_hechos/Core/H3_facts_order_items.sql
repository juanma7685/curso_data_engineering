{{ config(
    materialized='incremental',
    unique_key='order_items_id'
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
        order_items_id,
        order_id,
        product_id,
        quantity,
        llegada_id
    from source_order_items  
)

select * from facts_order_items
