

with 

source as (
    select distinct *
    from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.products
),

renamed as (
    select
        md5(cast(coalesce(cast(name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_id,
        price::decimal(10, 2) as precio,
        name as nombre_producto,
        md5(cast(coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as category_id,
        inventory,
        _DLT_LOAD_ID as llegada_id
    from source
),

no_products as (
    select distinct
        md5(cast(coalesce(cast(null as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(null as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_id,
        0 as precio,
        'no products' as nombre_producto,
        md5(cast(coalesce(cast('no products' as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as category_id,
        0 as inventory,
        '0' as llegada_id
),

deduplicated as (
    select *, 
           row_number() over (partition by product_id order by llegada_id desc) as row_num
    from (
        select * from renamed
        union all
        select * from no_products
    )
)

select *
from deduplicated
where row_num = 1


and llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__products)
