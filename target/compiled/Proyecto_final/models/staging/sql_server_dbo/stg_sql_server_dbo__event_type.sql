

with 

source as (
    select * from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.events
),

renamed as (
    select
        event_type,
        md5(cast(coalesce(cast(event_type as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as event_type_id,
        _DLT_LOAD_ID as llegada_id
    from source
    group by event_type, _DLT_LOAD_ID
)

select * from renamed



where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__event_type)

