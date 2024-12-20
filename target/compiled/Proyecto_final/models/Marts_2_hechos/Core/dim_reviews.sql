

with 

source as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__reviews
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_reviews)
    
),

renamed as (
    select
        review_id,
        user_id,
        product_id,
        rating,
        comments,
        created_at,
        llegada_id
    from source
)

select * from renamed