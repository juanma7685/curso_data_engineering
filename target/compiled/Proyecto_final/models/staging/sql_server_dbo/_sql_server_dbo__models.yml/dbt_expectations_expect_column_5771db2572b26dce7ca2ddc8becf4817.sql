






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and EUR_discount >= 0 and EUR_discount <= 1000
)
 as expression


    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__promos
    

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







