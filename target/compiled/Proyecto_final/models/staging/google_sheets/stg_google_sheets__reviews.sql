

with

    source as (
        select * from ALUMNO11_PRO_BRONZE_DB.google_sheets.reviews
    ),

    renamed as (

        select
            review_id,
            md5(cast(coalesce(cast(email as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as user_id,
            md5(cast(coalesce(cast(name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_id,
            rating::int as rating,
            comments,
            CAST(created_at AS DATE) as created_at,
            _DLT_LOAD_ID as llegada_id
        from source

    )

    select * from renamed


where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__reviews)
