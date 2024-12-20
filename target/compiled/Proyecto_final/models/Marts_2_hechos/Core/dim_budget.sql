


with 

source as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__budget
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_budget)
    
),

renamed as (
    select
        budget_id,
        product_id,
        quantity,
        mes,
        anyo,
        llegada_id
    from source
)

select * from renamed