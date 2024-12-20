

with 

source_orders as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__orders
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_orders)
    
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