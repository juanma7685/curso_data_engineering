

with 

source as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__returns
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_returns)
    
),

renamed as (
    select
        return_id,
        order_id,
        user_id,
        return_date,
        llegada_id
    from source
)

select * from renamed