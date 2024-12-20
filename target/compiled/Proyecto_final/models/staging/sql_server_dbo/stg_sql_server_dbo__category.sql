

with 

source as (
    select * 
    from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.products
),

renamed as (
    select DISTINCT
        md5(cast(coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as category_id,
        category,
        _DLT_LOAD_ID as llegada_id
    from source
),

deduplicated as (
    select *, 
           row_number() over (partition by category_id order by llegada_id desc) as row_num
    from renamed
)

select *
from deduplicated
where row_num = 1


and llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__category)
