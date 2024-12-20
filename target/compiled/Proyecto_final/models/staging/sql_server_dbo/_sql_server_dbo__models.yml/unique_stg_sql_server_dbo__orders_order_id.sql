
    
    

select
    order_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__orders
where order_id is not null
group by order_id
having count(*) > 1


