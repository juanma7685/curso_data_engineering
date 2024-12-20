

with

    source as (
        select * from ALUMNO11_PRO_BRONZE_DB.google_sheets.returns
    ),

    renamed as (

        select
            return_id,
            order_id,
            md5(cast(coalesce(cast(email as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as user_id,
            CAST(return_date as date) as return_date,
            _DLT_LOAD_ID as llegada_id
        from source

    )

    select * from renamed


where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__returns)
