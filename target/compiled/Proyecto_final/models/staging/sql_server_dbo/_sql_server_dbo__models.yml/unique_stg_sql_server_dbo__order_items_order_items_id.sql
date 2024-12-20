
    
    

select
    order_items_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__order_items
where order_items_id is not null
group by order_items_id
having count(*) > 1


