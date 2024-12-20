
  
    

        create or replace transient table ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_fecha
         as
        (with 

source as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.fecha
),

renamed as (
    select
        date_day,
        year,
        month,
        day,
        week,
        day_of_week,
        day_of_year,
        quarter,
        day_type,
        day_name
    from source
)

select * from renamed
        );
      
  