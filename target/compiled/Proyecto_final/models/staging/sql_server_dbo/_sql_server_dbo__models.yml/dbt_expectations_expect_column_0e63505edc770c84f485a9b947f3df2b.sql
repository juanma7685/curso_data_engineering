





    with grouped_expression as (
    select
        
        
    
  
( 1=1 and length(
        zipcode
    ) >= 5 and length(
        zipcode
    ) <= 10
)
 as expression


    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__addresses
    

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






