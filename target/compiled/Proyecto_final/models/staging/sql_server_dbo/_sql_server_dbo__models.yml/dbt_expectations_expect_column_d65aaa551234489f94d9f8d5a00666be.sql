




    with grouped_expression as (
    select
        
        
    
  


    
regexp_instr(page_url, '^(http|https)://', 1, 1, 0, '')


 > 0
 as expression


    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__events
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors




