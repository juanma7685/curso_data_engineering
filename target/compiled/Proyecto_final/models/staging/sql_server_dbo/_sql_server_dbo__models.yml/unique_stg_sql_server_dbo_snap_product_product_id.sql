
    
    

select
    product_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo_snap_product
where product_id is not null
group by product_id
having count(*) > 1


