
    
    

select
    return_id as unique_field,
    count(*) as n_records

from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__returns
where return_id is not null
group by return_id
having count(*) > 1


