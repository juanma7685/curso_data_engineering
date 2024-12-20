






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and rating >= 1 and rating <= 5
)
 as expression


    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__reviews
    

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







