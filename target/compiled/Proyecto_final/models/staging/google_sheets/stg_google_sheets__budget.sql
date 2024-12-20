

with source as (
    select * from ALUMNO11_PRO_BRONZE_DB.google_sheets.budget
),

renamed as (
    select
        md5(cast(coalesce(cast(name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(quantity as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(month as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as budget_id,
        md5(cast(coalesce(cast(name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_id,
        quantity::int as quantity,
        Month(month) as mes,
        Year(month) as anyo,
        _DLT_LOAD_ID as llegada_id
    from source
),

deduplicated as (
    select *,
        row_number() over (partition by budget_id order by llegada_id desc) as row_num
    from renamed
)

select *
from deduplicated
where row_num = 1


and llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__budget)
