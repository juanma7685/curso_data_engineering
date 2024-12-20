






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and inventory >= 0
)
 as expression


    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo_snap_product
    

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







