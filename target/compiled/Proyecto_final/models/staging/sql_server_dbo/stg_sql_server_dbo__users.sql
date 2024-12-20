

with 

source as (
    select * from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.users
),

renamed as (
    select
        md5(cast(coalesce(cast(email as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as user_id,
        CAST(updated_at AS DATE) as updated_at,
        md5(cast(coalesce(cast(address as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(zipcode as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(country as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(state as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as address_id,
        last_name,
        CAST(created_at AS DATE) as created_at,
        phone_number,
        first_name,
        email,
        _DLT_LOAD_ID as llegada_id
    from source
)

select * from renamed


where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__users)
