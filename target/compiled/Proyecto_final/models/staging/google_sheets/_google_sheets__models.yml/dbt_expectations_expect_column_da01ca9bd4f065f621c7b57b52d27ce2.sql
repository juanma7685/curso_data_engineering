






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and anyo >= 2020
)
 as expression


    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__budget
    

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







