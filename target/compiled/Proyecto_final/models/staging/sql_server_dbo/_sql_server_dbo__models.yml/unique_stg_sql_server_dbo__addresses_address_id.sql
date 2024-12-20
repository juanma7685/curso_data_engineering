
    
    

select
    address_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__addresses
where address_id is not null
group by address_id
having count(*) > 1


