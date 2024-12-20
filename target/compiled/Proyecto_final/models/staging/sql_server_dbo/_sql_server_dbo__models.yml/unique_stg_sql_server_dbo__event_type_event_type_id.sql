
    
    

select
    event_type_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__event_type
where event_type_id is not null
group by event_type_id
having count(*) > 1


