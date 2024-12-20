

with 

-- 1. Fuente de datos
source as (
    select distinct *
    from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.promos
),

-- 2. Datos renombrados
renamed as (
    select
        md5(cast(coalesce(cast(promo_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as promo_id,
        promo_id as name,
        discount as EUR_discount,
        status,
        _DLT_LOAD_ID as llegada_id
    from source
),

-- 3. Promos predeterminadas
no_promos as (
    select distinct
        md5(cast(coalesce(cast(null as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as promo_id,
        'no promo' as name,
        null as EUR_discount,
        null as status,
        '0' as llegada_id
),

-- 4. Deduplicación y manejo de conflictos
deduplicated as (
    select *, 
           row_number() over (partition by promo_id order by llegada_id desc) as row_num
    from (
        select * from renamed
        union all
        select * from no_promos
    )
)

-- 5. Selección final
select *
from deduplicated
where row_num = 1


and llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__promos)
