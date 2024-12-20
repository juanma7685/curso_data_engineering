
    
    

select
    event_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__events
where event_id is not null
group by event_id
having count(*) > 1


