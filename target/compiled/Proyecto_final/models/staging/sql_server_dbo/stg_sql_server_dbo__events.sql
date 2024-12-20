

with 

source as (

    select * from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.events

),

renamed as (

    select
        event_id,
        page_url,
        -- Extraer el dominio de la URL
        regexp_substr(page_url, '^(https?://[^/]+)') as domain,
        -- Extraer el ID único de la URL
        regexp_substr(page_url, '[^/]+$', 1, 1) as page_id,
        md5(cast(coalesce(cast(event_type as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as event_type_id,
        md5(cast(coalesce(cast(email as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as user_id,
        md5(cast(coalesce(cast(name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_id,   
        session_id,
        CAST(created_at AS DATE) as created_at,
        _DLT_LOAD_ID as llegada_id

    from source

)

select * from renamed


where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__events)
