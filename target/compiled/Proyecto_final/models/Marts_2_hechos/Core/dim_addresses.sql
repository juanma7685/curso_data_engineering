

with 
source as (
    select * 
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__addresses
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_addresses) -- Solo datos nuevos o actualizados
    
),

renamed as (
    select
        address_id,
        zipcode,
        country,
        address,
        street,
        address_number,
        state,
        llegada_id
    from source
)

select * from renamed