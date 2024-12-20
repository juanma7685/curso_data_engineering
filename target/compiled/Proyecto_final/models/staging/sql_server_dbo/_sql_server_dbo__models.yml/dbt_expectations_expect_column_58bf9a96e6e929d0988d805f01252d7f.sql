






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and shipping_cost >= 0 and shipping_cost <= 500
)
 as expression


    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__orders
    

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







