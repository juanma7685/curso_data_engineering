





    with grouped_expression as (
    select
        
        
    
  
( 1=1 and length(
        comments
    ) >= 0 and length(
        comments
    ) <= 1000
)
 as expression


    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__snap_reviews
    

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






