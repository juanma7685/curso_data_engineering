

with 

source_orders as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__orders
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.facts_orders)
    
),

source_order_items as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__order_items
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.facts_orders)
    
),

facts_orders as (
    select
        o.order_id,
        o.address_id,
        o.user_id,
        oi.order_items_id,
        oi.product_id,
        oi.quantity,
        oi.llegada_id
    from source_orders o
    join source_order_items oi on o.order_id = oi.order_id
)

select * from facts_orders