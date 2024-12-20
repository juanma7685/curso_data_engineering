
    
    

select
    shipping_service_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__shipping_service
where shipping_service_id is not null
group by shipping_service_id
having count(*) > 1


