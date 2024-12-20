
    
    

select
    status_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__status
where status_id is not null
group by status_id
having count(*) > 1


