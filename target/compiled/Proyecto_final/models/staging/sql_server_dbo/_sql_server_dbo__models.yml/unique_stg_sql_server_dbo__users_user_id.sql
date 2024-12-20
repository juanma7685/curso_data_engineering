
    
    

select
    user_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__users
where user_id is not null
group by user_id
having count(*) > 1


