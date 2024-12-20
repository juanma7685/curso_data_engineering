

with 

source_order_items as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__order_items
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_order_items)
    
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