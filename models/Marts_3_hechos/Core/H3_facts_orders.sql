{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

with 

source_orders as (
    select * from {{ ref('stg_sql_server_dbo__orders') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),

facts_orders as (
    select
        o.order_id,
        o.address_id,
        o.user_id,
    from source_orders o
)

select * from facts_orders
