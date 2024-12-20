

with 

source as (
    select * from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.orders
),

renamed as (
    select
        md5(cast(coalesce(cast(status as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as status_id,
        status,
        _DLT_LOAD_ID as llegada_id
    from source
),

deduplicated as (
    select *, 
           row_number() over (partition by status_id order by llegada_id desc) as row_num
    from renamed
)

select *
from deduplicated
where row_num = 1



and llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__status)

