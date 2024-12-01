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
        order_id,
        address_id,
        user_id,
        llegada_id
    from source_orders
)

select * from facts_orders
